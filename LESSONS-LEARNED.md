# Franklab - Lessons Learned

**Versie:** 1.0
**Datum:** 2026-01-06
**Doel:** Documentatie van belangrijke lessen, valkuilen en best practices uit real-world ervaring

---

## 🎯 Overzicht

Dit document bevat praktische lessen die we hebben geleerd tijdens development van Franklab projecten. Elke les bevat:
- **Context**: Wat ging er mis/goed?
- **Root Cause**: Waarom gebeurde dit?
- **Solution**: Hoe hebben we het opgelost?
- **Prevention**: Hoe voorkomen we dit in de toekomst?
- **Reference**: Link naar relevante code/commits

---

## 🔒 Security & CORS

### Lesson #1: CORS met Credentials - Wildcard Origins Werken Niet

**Datum:** 2026-01-06
**Project:** Insurance Data Platform
**Severity:** 🔴 Critical (Blokkeerde alle authenticated API calls)

#### Context
Na backend restart kregen we continu 403 Forbidden errors op alle authenticated endpoints:
```
GET /api/v1/notifications/unread/count 403 Forbidden
{"detail":"Not authenticated"}
```

Frontend stuurde geen Authorization header, ondanks dat de token wel in localStorage zat.

#### Root Cause
CORS configuratie was incorrect voor credential-based authentication:

```python
# ❌ FOUT - Werkt NIET met credentials
cors_origins = ["*"]  # Wildcard
app.add_middleware(
    CORSMiddleware,
    allow_origins=cors_origins,
    allow_credentials=False,  # Credentials uitgeschakeld!
    ...
)
```

**Volgens CORS spec:**
- Als `allow_origins = ["*"]` (wildcard), dan **moet** `allow_credentials = False`
- Als `allow_credentials = True`, dan **moet** je specifieke origins opgeven

**Resultaat:** Browser weigert Authorization headers te sturen bij wildcard CORS.

#### Solution

```python
# ✅ CORRECT - Specifieke origins met credentials
if settings.DEBUG:
    cors_origins = [
        # Local development
        "http://localhost:5173",
        "http://localhost:3000",
        "https://localhost:5173",
        "https://localhost:3000",
        # Network/Tailscale access
        "http://127.0.0.1:5173",
        "http://192.168.2.5:5173",
    ]
else:
    cors_origins = settings.CORS_ORIGINS

app.add_middleware(
    CORSMiddleware,
    allow_origins=cors_origins,  # Specifieke origins
    allow_credentials=True,      # Credentials toegestaan
    allow_methods=["*"],
    allow_headers=["*"],
    # Bonus: regex voor flexibele IP ranges
    allow_origin_regex=r"https?://192\.168\.\d+\.\d+(:\d+)?" if settings.DEBUG else None,
)
```

#### Prevention Checklist

**Bij CORS configuratie, ALTIJD checken:**

- [ ] Gebruik je JWT/Bearer tokens? → `allow_credentials=True` VEREIST
- [ ] Gebruik je cookies voor auth? → `allow_credentials=True` VEREIST
- [ ] Development mode? → Specifieke localhost origins (niet `*`)
- [ ] Network/Tailscale access? → Voeg specifieke IPs toe OF gebruik `allow_origin_regex`
- [ ] Production mode? → Alleen production domains in `allow_origins`

**Code Review Checklist:**
```python
# Check deze combinaties:
❌ allow_origins=["*"] + allow_credentials=True     # INVALID (browser rejects)
❌ allow_origins=["*"] + JWT auth                   # BROKEN (no auth headers sent)
✅ allow_origins=[specific] + allow_credentials=True # CORRECT
✅ allow_origins=[specific] + allow_origin_regex    # CORRECT (flexible)
```

#### Testing CORS Locally

```bash
# Test 1: Verify CORS headers
curl -X OPTIONS "https://192.168.2.5:8001/api/v1/notifications/unread/count" \
  -H "Origin: https://192.168.2.5:5173" \
  -H "Access-Control-Request-Method: GET" \
  -H "Access-Control-Request-Headers: Authorization" \
  -v

# Verwacht response:
# Access-Control-Allow-Origin: https://192.168.2.5:5173
# Access-Control-Allow-Credentials: true
# Access-Control-Allow-Headers: authorization

# Test 2: Verify authenticated request works
curl -X GET "https://192.168.2.5:8001/api/v1/notifications/unread/count" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Origin: https://192.168.2.5:5173" \
  -k -v

# Verwacht: 200 OK (niet 403!)
```

#### References
- **File:** `backend/app/main.py` (lines 119-148)
- **Commit:** CORS fix voor credentials support
- **Spec:** [MDN CORS Credentials](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS#requests_with_credentials)

---

## 🖼️ Media & Streaming

### Lesson #2: StreamingResponse vs Response voor Binary Data

**Datum:** 2026-01-06
**Project:** Insurance Data Platform
**Severity:** 🟡 Medium (Thumbnails faalden intermittent)

#### Context
Thumbnail images faalden met `ERR_INCOMPLETE_CHUNKED_ENCODING`:
```
GET /api/v1/documents/{id}/thumbnail
net::ERR_INCOMPLETE_CHUNKED_ENCODING 200 (OK)
```

Status was 200, maar browser kreeg incomplete data. Thumbnails werden niet getoond.

#### Root Cause
Gebruik van `StreamingResponse` met `BytesIO` voor binary data in combinatie met GZipMiddleware:

```python
# ❌ PROBLEMATISCH - Chunked encoding issues
from fastapi.responses import StreamingResponse
import io

thumbnail_data = await storage_service.download_file(path)
return StreamingResponse(
    io.BytesIO(thumbnail_data),  # Stream van bytes
    media_type="image/jpeg",
    headers={"Content-Length": str(len(thumbnail_data))}
)
```

**Wat er gebeurt:**
1. `StreamingResponse` gebruikt chunked transfer encoding
2. GZipMiddleware probeert chunks te comprimeren
3. JPEG data is al gecomprimeerd (niet compressible)
4. Middleware/browser raakt in de war met chunks
5. Incomplete data → `ERR_INCOMPLETE_CHUNKED_ENCODING`

#### Solution

```python
# ✅ CORRECT - Direct Response voor binary data
from fastapi.responses import Response

thumbnail_data = await storage_service.download_file(path)
return Response(
    content=thumbnail_data,  # Direct bytes, geen stream
    media_type="image/jpeg",
    headers={
        "Content-Disposition": f'inline; filename="thumbnail_{document.id}.jpg"',
        "Content-Length": str(len(thumbnail_data)),
        "Cache-Control": "public, max-age=3600",
    }
)
```

**Waarom werkt dit beter?**
- Geen chunked encoding (hele response in 1 keer)
- GZipMiddleware skipT binary data (image/jpeg)
- Browser krijgt complete data gegarandeerd
- Simpeler en betrouwbaarder

#### Prevention Guidelines

**Gebruik StreamingResponse ALLEEN voor:**
- ✅ Grote bestanden (>10MB) die niet in memory passen
- ✅ Real-time data streams (WebSocket, SSE)
- ✅ Video/audio streaming met range requests
- ✅ Database cursor iteratie (grote datasets)

**Gebruik Response (direct) voor:**
- ✅ Images/thumbnails (<5MB)
- ✅ PDFs (<10MB)
- ✅ JSON responses
- ✅ Any binary data waarbij je de volledige content al hebt

**Decision Tree:**
```
Data al volledig in memory?
├─ Ja + <10MB  → Response(content=data)
├─ Ja + >10MB  → StreamingResponse (of optimize memory usage)
└─ Nee (lazy)  → StreamingResponse
```

#### Code Pattern

```python
# Pattern: Binary response met caching
async def get_binary_resource(resource_id: UUID):
    """Generic pattern voor images, PDFs, etc."""
    data = await storage.download(resource_id)

    return Response(
        content=data,
        media_type="image/jpeg",  # of application/pdf, etc.
        headers={
            "Content-Disposition": f'inline; filename="{resource_id}.jpg"',
            "Content-Length": str(len(data)),
            "Cache-Control": "public, max-age=3600",  # 1 hour browser cache
            "ETag": hashlib.md5(data).hexdigest(),    # Voor conditional requests
        }
    )
```

#### References
- **File:** `backend/app/api/v1/endpoints/documents.py` (line 641-655)
- **FastAPI Docs:** [Custom Response](https://fastapi.tiangolo.com/advanced/custom-response/)

---

## 🐛 Error Handling

### Lesson #3: Failed Document Processing - Move to _Fail Folder

**Datum:** 2026-01-06
**Project:** Insurance Data Platform - Folder Watch Service
**Severity:** 🟢 Low (Quality of life improvement)

#### Context
Folder watch service importeerde documenten automatisch, maar failed files bleven in de import folder liggen zonder duidelijke reden waarom ze faalden.

#### Solution

Organized failure handling met date-based folder structure:

```python
async def _move_to_fail(self, file_path: Path, error_message: str):
    """
    Move failed file to _Fail/YYYY/MM/DD/ folder structure.
    Create .error.txt file with failure details.
    """
    # Create date-based folder structure
    now = datetime.now()
    fail_folder = watch_folder / "_Fail" / str(now.year) / f"{now.month:02d}" / f"{now.day:02d}"
    fail_folder.mkdir(parents=True, exist_ok=True)

    # Move file
    shutil.move(str(file_path), str(destination))

    # Create error info file
    error_file = destination.with_suffix(destination.suffix + ".error.txt")
    error_file.write_text(
        f"Failed to import: {file_path.name}\n"
        f"Timestamp: {now.isoformat()}\n"
        f"Error: {error_message}\n",
        encoding='utf-8'
    )
```

**Folder Structure:**
```
/mnt/import/
├── _Processed/          # Successful imports
│   └── 2026/01/06/
│       └── document.pdf
└── _Fail/               # Failed imports
    └── 2026/01/06/
        ├── failed_doc.pdf
        └── failed_doc.pdf.error.txt  # Error details
```

#### Prevention Pattern

**Voor alle batch/import processing:**

```python
try:
    # Process file
    result = await process_file(file_path)
    await move_to_success(file_path)
except Exception as e:
    # Never leave failed files in limbo
    await move_to_fail(file_path, error=str(e))
    # Mark as processed to avoid infinite retry
    self._processed_files.add(file_key)
```

**Best Practices:**
- ✅ Date-based folder structure (easy to find recent failures)
- ✅ Preserve original filename
- ✅ Create `.error.txt` with timestamp + error message
- ✅ Handle filename conflicts (add timestamp suffix)
- ✅ Mark as "processed" to avoid infinite retry loops
- ✅ Log failure (for monitoring/alerting)

#### References
- **File:** `backend/app/services/folder_watch_service.py` (lines 210-265)

---

## 🔄 Dependencies & Service Interactions

### Lesson #4: Backend Restart Invalidates Frontend Tokens (In Development)

**Datum:** 2026-01-06
**Project:** Insurance Data Platform
**Severity:** 🟡 Medium (Development annoyance)

#### Context
Na backend restart kregen we:
1. 403 errors op authenticated endpoints
2. Notificaties laadden niet meer
3. Thumbnails faalden

Dit is VERWACHT GEDRAG in development (SECRET_KEY blijft hetzelfde), maar kan verwarrend zijn.

#### Root Cause

**JWT Token Validation:**
1. Backend gebruikt `SECRET_KEY` om tokens te signen
2. Tokens bevatten expiry time (`exp`)
3. Bij backend restart:
   - `SECRET_KEY` blijft zelfde (dev mode)
   - Tokens zijn technisch nog valid
   - **MAAR:** Backend staat kan veranderen (bijv. CORS config)

**In deze situatie:** CORS config was gewijzigd, maar oude tokens werden gebruikt met verkeerde CORS settings.

#### Solution

**Development:** Browser cache + localStorage clearen na backend restart:

```javascript
// Quick fix in browser console
localStorage.clear();
location.reload();
```

**Betere oplossing:** Frontend detecteert backend restart automatisch:

```typescript
// axios interceptor voor detecting backend restart
apiClient.interceptors.response.use(
  (response) => response,
  async (error) => {
    if (error.response?.status === 403) {
      // Check if backend restarted (version endpoint)
      const backendVersion = await getBackendVersion();
      const storedVersion = localStorage.getItem('backend_version');

      if (backendVersion !== storedVersion) {
        // Backend restarted - clear auth
        localStorage.clear();
        window.location.href = '/login?reason=backend_restart';
      }
    }
    return Promise.reject(error);
  }
);
```

#### Prevention

**Development Setup:**
```bash
# Add to backend startup
@app.on_event("startup")
async def startup():
    logger.info(f"🚀 Backend started - Version: {settings.APP_VERSION}")
    # Increment version on each restart (development only)
    if settings.DEBUG:
        import time
        settings.RUNTIME_VERSION = int(time.time())
```

**Production:** Gebruik token refresh mechanism:
- Access tokens: 15-30 min expiry
- Refresh tokens: 7 days expiry
- Backend restart → clients refresh automatisch

#### References
- **Related:** CORS Lesson #1 (vaak samen)
- **See:** `frontend/src/services/api.ts` voor interceptors

---

## 📋 Template voor Nieuwe Lessons

```markdown
### Lesson #{number}: {Korte Titel}

**Datum:** YYYY-MM-DD
**Project:** {Project Name}
**Severity:** 🔴 Critical / 🟡 Medium / 🟢 Low

#### Context
{Wat ging er mis? Wat waren de symptomen?}

#### Root Cause
{Waarom gebeurde dit? Technische details.}

#### Solution
{Hoe hebben we het opgelost? Code voorbeelden.}

#### Prevention
{Hoe voorkomen we dit? Checklist, patterns, etc.}

#### References
- **File:** {filename} (line numbers)
- **Commit:** {commit hash or description}
- **Related:** {Links naar andere lessons/docs}
```

---

## 🎯 Best Practices Samenvatting

### CORS & Authentication
1. ✅ **Nooit** `allow_origins=["*"]` met credentials
2. ✅ **Altijd** specifieke origins voor authenticated APIs
3. ✅ Test CORS met `curl -X OPTIONS` voor deployment
4. ✅ Gebruik `allow_origin_regex` voor development flexibility

### Binary Responses
1. ✅ Gebruik `Response(content=data)` voor images/PDFs in memory
2. ✅ Alleen `StreamingResponse` voor >10MB of lazy loading
3. ✅ Zet `Content-Length` header voor browser caching
4. ✅ Overweeg `ETag` voor conditional requests

### Error Handling
1. ✅ Failed files → dedicated folder met timestamp
2. ✅ Schrijf `.error.txt` naast failed files
3. ✅ Log errors voor monitoring
4. ✅ Voorkom infinite retry loops

### Development Workflow
1. ✅ Backend restart → frontend refresh (of auto-detect)
2. ✅ Test authentication flow na config changes
3. ✅ Check browser DevTools Network tab voor CORS errors
4. ✅ Clear localStorage bij hardnekkige auth issues

---

## 📞 Bijdragen aan dit Document

**Nieuwe lesson toevoegen?**

```bash
# 1. Update LESSONS-LEARNED.md
code d:/dev/agents/LESSONS-LEARNED.md

# 2. Gebruik template hierboven

# 3. Commit met duidelijke message
git commit -m "docs(lessons): add lesson about {onderwerp}"

# 4. Notify team
# Tag @team in commit of chat
```

**Wanneer lesson toevoegen?**
- 🔴 Critical bug die >1 uur kostte om te debuggen
- 🟡 Subtiele issue die anderen ook kunnen tegenkomen
- 🟢 Interessante pattern/workaround die nuttig is

---

**Versie:** 1.0
**Auteur:** Claude (AI Developer) + Frank
**Laatst bijgewerkt:** 2026-01-06

**🎯 "De beste lessen komen van fouten. De tweede-beste lessen komen van andermans fouten lezen."**
