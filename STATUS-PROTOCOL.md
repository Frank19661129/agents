# Agent Status Update Protocol

**Versie:** 1.0
**Datum:** 2025-01-05
**Status:** Active

---

## 🎯 Doel

Dit protocol definieert hoe agents hun status schrijven naar `project_agent_status.md` files. Hiermee kunnen:
- Andere agents zien wat je doet
- Frank zien wat de voortgang is
- Jezelf context bewaren bij restart
- Team Lead (Ulle) overzicht houden

---

## 📁 File Naming Convention

**Format:** `{project}_{agent}_status.md`

**Voorbeelden:**
```
pai_dev_status.md              # Janbu (dev) werkt aan PAI
pepper-web_dpl_status.md       # Goof (dpl) deployt Pepper-web
insurance-data_dat_status.md   # Lordi (dat) maakt BI dashboard
pai_atl_status.md              # Ulle (atl) doet architectuur review
```

**Locatie:** `d:/dev/agents/status/`

---

## 📝 Status File Template

Kopieer deze template voor nieuwe status files:

```markdown
# {Project} - {Agent Name} Status

**Agent:** {Agent Name} ({agent-tag})
**Project:** {Project Name}
**Laatst bijgewerkt:** {YYYY-MM-DD HH:MM}
**Status:** {Thinking | Planning | Executing | Testing | Review | Blocked | Completed}

---

## 🎯 Huidige Taak

**Titel:** {Korte titel van de taak}

**Beschrijving:**
{1-3 zinnen wat je aan het doen bent}

**Prioriteit:** {P0 | P1 | P2 | P3}

**Verwachte Afronding:** {Datum of "Vandaag" / "Deze week"}

---

## 📊 Voortgang

**Percentage:** {0-100}%

**Stappen:**
- [x] Stap 1 voltooid
- [x] Stap 2 voltooid
- [ ] Stap 3 in progress 👈 NU HIER
- [ ] Stap 4 te doen
- [ ] Stap 5 te doen

---

## 💡 Bevindingen

**Wat werkt goed:**
- {Bevinding 1}
- {Bevinding 2}

**Uitdagingen:**
- {Uitdaging 1}
- {Uitdaging 2}

**Beslissingen:**
- {Beslissing 1 met rationale}
- {Beslissing 2 met rationale}

---

## 🔗 Dependencies & Collaboratie

**Wacht op:**
- {Agent} moet {taak} afronden (ETA: {datum})

**Samenwerking met:**
- {Agent}: {wat jullie samen doen}

**Blockers:**
- {Blocker 1 met beschrijving}

---

## ✅ Volgende Stappen

1. {Volgende actie 1}
2. {Volgende actie 2}
3. {Volgende actie 3}

---

## 📝 Notities & Context

**Relevante Links:**
- {Link 1 met beschrijving}
- {Link 2 met beschrijving}

**Technische Details:**
- {Detail 1}
- {Detail 2}

**Voor bij restart:**
{Belangrijke context die je nodig hebt als je deze taak weer oppakt}

---

## 📅 Historie (Laatste 5 Updates)

### {YYYY-MM-DD HH:MM} - Status: {Status}
{Korte samenvatting van update}

### {YYYY-MM-DD HH:MM} - Status: {Status}
{Korte samenvatting van update}

---

**Laatste update door:** {Agent Name}
**Volgende review:** {Datum of "Bij volgende milestone"}
```

---

## 🎨 Status Types

| Status | Betekenis | Gebruik |
|--------|-----------|---------|
| **Thinking** | Aan het nadenken over aanpak | Beginnen van nieuwe taak, exploratie |
| **Planning** | Aan het plannen/designen | Architectuur, user stories, test plan |
| **Executing** | Actief aan het bouwen/implementeren | Code schrijven, configureren |
| **Testing** | Aan het testen | Unit tests, integration tests, QA |
| **Review** | Wacht op of doet review | Code review, security review |
| **Blocked** | Geblokkeerd door dependencies | Wacht op andere agent, externe input |
| **Completed** | Taak afgerond | Klaar, gemerged, gedeployed |

---

## ✍️ Update Frequentie

### Minimaal:
- **Bij start van taak** (Status: Thinking/Planning)
- **Bij belangrijke milestone** (bijv. design klaar, implementatie 50%)
- **Bij blocker** (Status: Blocked)
- **Bij completion** (Status: Completed)

### Aanbevolen:
- **Elke 2-3 uur** tijdens actief werk
- **Voor lunchpauze** (zodat je na lunch weet waar je was)
- **Einde van de dag** (voor continuïteit volgende dag)
- **Voor agent restart** (altijd!)

### ALTIJD:
- **Voor restart** van jezelf (zodat je na restart context hebt)
- **Bij escalatie** naar Team Lead
- **Bij handover** naar andere agent

---

## 📋 Voorbeelden

### Voorbeeld 1: Janbu (DEV) werkt aan PAI inbox bug

**File:** `d:/dev/agents/status/pai_dev_status.md`

```markdown
# PAI - Janbu (Developer) Status

**Agent:** Janbu (dev)
**Project:** PAI Backend
**Laatst bijgewerkt:** 2025-01-05 14:30
**Status:** Executing

---

## 🎯 Huidige Taak

**Titel:** Fix Inbox Page Infinite Loading Bug

**Beschrijving:**
InboxPage component toont "Laden..." oneindig. Debugging wijst op useEffect dependency array issue. Bezig met fix implementeren en testen.

**Prioriteit:** P1 (Hoog)

**Verwachte Afronding:** Vandaag

---

## 📊 Voortgang

**Percentage:** 70%

**Stappen:**
- [x] Reproduceer bug lokaal
- [x] Add debug logging
- [x] Identificeer root cause (useEffect missing deps)
- [x] Implementeer fix in InboxPage.tsx
- [ ] Test fix in browser 👈 NU HIER
- [ ] Write unit test voor fix
- [ ] Code review door ATL
- [ ] Merge naar develop

---

## 💡 Bevindingen

**Wat werkt goed:**
- Debug logging hielp snel root cause vinden
- Fix is simpel (1 regel wijziging)

**Uitdagingen:**
- Geen - straightforward fix

**Beslissingen:**
- Added empty dependency array to useEffect (prevents re-render loop)
- Rationale: Component should only load data on mount, not on every render

---

## 🔗 Dependencies & Collaboratie

**Wacht op:**
Geen

**Samenwerking met:**
- ATL (Ulle): Code review nodig na mijn tests

**Blockers:**
Geen

---

## ✅ Volgende Stappen

1. Test fix in browser (npm run dev)
2. Verify inbox items load correctly
3. Write unit test with Vitest
4. Request code review van Ulle
5. Merge naar develop na approval

---

## 📝 Notities & Context

**Relevante Links:**
- Fix commit: [pending]
- Issue: PAI #42 (inbox loading bug)

**Technische Details:**
- File: pai-client/src/pages/InboxPage.tsx
- Change: Line 47 - added empty dependency array to useEffect
- Before: `useEffect(() => { loadInbox(); })`
- After: `useEffect(() => { loadInbox(); }, [])`

**Voor bij restart:**
Als browser test slaagt, unit test schrijven. Als test faalt, check of API response correct is (mogelijk backend issue).

---

## 📅 Historie (Laatste 5 Updates)

### 2025-01-05 14:30 - Status: Executing
Implementeerde fix, nu aan het testen

### 2025-01-05 13:15 - Status: Executing
Root cause gevonden: missing dependency array in useEffect

### 2025-01-05 12:00 - Status: Thinking
Debug logging toegevoegd, bezig met analyse

### 2025-01-05 10:30 - Status: Planning
Bug reproduceren en debug strategie bepalen

---

**Laatste update door:** Janbu (dev)
**Volgende review:** Na completion door ATL
```

---

### Voorbeeld 2: Goof (DPL) setup CI/CD voor Pepper-web

**File:** `d:/dev/agents/status/pepper-web_dpl_status.md`

```markdown
# Pepper-web - Goof (DevOps) Status

**Agent:** Goof (dpl)
**Project:** Pepper-web (React Client)
**Laatst bijgewerkt:** 2025-01-05 16:45
**Status:** Planning

---

## 🎯 Huidige Taak

**Titel:** Setup CI/CD Pipeline voor Pepper-web

**Beschrijving:**
Implementeer GitHub Actions workflow voor Pepper-web met linting, testing, building, en deployment naar staging environment.

**Prioriteit:** P1 (Hoog - volgens ARCHITECTUUR.md TODO #4)

**Verwachte Afronding:** Morgen

---

## 📊 Voortgang

**Percentage:** 30%

**Stappen:**
- [x] Analyseer huidige project structuur
- [x] Definieer pipeline stages (lint, test, build, deploy)
- [x] Research GitHub Actions templates
- [ ] Schrijf .github/workflows/ci-cd.yml 👈 NU HIER
- [ ] Test pipeline op feature branch
- [ ] Add deployment secrets (DOCKER_USERNAME, etc.)
- [ ] Test auto-deploy naar staging
- [ ] Documenteer in README.md

---

## 💡 Bevindingen

**Wat werkt goed:**
- Project heeft al ESLint + Prettier configured
- Vitest setup voor tests aanwezig (maar coverage < 80%)

**Uitdagingen:**
- Deployment target nog niet gedefinieerd (Docker? Vercel? Netlify?)
- Test coverage is laag (~45%), moet naar 80% volgens ARCHITECTUUR.md

**Beslissingen:**
- Pipeline blokkeren bij test failures (quality gate)
- Pipeline blokkeren bij coverage < 80% (afdwingen ARCHITECTUUR.md requirement)
- Deployment naar Docker container (consistent met PAI backend)
- Auto-deploy naar staging bij push naar develop branch
- Manual approval voor production deploy

---

## 🔗 Dependencies & Collaboratie

**Wacht op:**
- Frank: Beslissing over deployment environment (Docker Registry URL)

**Samenwerking met:**
- Janbu (dev): Heeft tests nodig voor coverage requirement
- ATL (Ulle): Review van pipeline design

**Blockers:**
- **BLOCKER:** Deployment target niet gedefinieerd (need Frank input)

---

## ✅ Volgende Stappen

1. **HOOG:** Escaleer deployment target vraag naar Frank (via ATL)
2. Schrijf GitHub Actions workflow (template klaar)
3. Test workflow op feature branch
4. Configureer secrets in GitHub repo
5. Documenteer deployment proces in README

---

## 📝 Notities & Context

**Relevante Links:**
- ARCHITECTUUR.md TODO #4: CI/CD pipeline overal doorvoeren
- GitHub Actions docs: https://docs.github.com/en/actions

**Technische Details:**
- Pipeline stages: Lint → Test → Security Scan → Build → Deploy
- Test: Vitest met coverage enforcement (80%)
- Security: Trivy scan voor dependencies
- Build: Docker multi-stage build
- Deploy: Push naar Docker Registry + trigger deployment webhook

**Voor bij restart:**
Wacht op Frank's beslissing over deployment environment. Als antwoord binnen is, finish workflow en test.

---

## 📅 Historie (Laatste 5 Updates)

### 2025-01-05 16:45 - Status: Planning
Pipeline design compleet, wacht op deployment target beslissing

### 2025-01-05 15:00 - Status: Thinking
Bezig met research GitHub Actions best practices

### 2025-01-05 14:00 - Status: Thinking
Taak opgepakt, analyseer huidige setup

---

**Laatste update door:** Goof (dpl)
**Volgende review:** Na deployment target beslissing
```

---

### Voorbeeld 3: Lordi (DAT) maakt BI dashboard

**File:** `d:/dev/agents/status/insurance-data_dat_status.md`

```markdown
# Insurance Data - Lordi (Data/Analytics) Status

**Agent:** Lordi (dat)
**Project:** Insurance Data Platform
**Laatst bijgewerkt:** 2025-01-05 11:20
**Status:** Executing

---

## 🎯 Huidige Taak

**Titel:** Create Claims Analysis BI Dashboard

**Beschrijving:**
Bouw BI dashboard in Metabase voor claims analytics met visualisaties voor claim trends, approval rates, en processing times.

**Prioriteit:** P2 (Medium)

**Verwachte Afronding:** Deze week (vrijdag)

---

## 📊 Voortgang

**Percentage:** 55%

**Stappen:**
- [x] Definieer KPIs met stakeholders
- [x] Design dashboard layout (wireframes)
- [x] Schrijf SQL queries voor data extraction
- [x] Create Metabase dashboard (basis layout)
- [ ] Add visualisaties (charts, graphs) 👈 NU HIER
- [ ] Optimize query performance
- [ ] Add filters (date range, claim type)
- [ ] UAT met key users
- [ ] Deploy naar production

---

## 💡 Bevindingen

**Wat werkt goed:**
- PostgreSQL views maken queries simpeler
- Metabase drag-and-drop interface is intuïtief

**Uitdagingen:**
- Enkele queries zijn traag (>5 seconden)
- Data quality issues in oude claims (NULL values)

**Beslissingen:**
- Created materialized views voor performance (refreshed daily)
- Added data quality filters in queries (exclude NULL/invalid records)
- Rationale: Better to show correct data slowly than fast incorrect data

---

## 🔗 Dependencies & Collaboratie

**Wacht op:**
Geen

**Samenwerking met:**
- Janbu (dev): Vraag over database indexing voor query optimization

**Blockers:**
Geen

---

## ✅ Volgende Stappen

1. Add trend line chart voor claims over time
2. Add pie chart voor claim types distribution
3. Add bar chart voor avg. processing time per type
4. Optimize slow queries (add indexes)
5. Test met key users (Frank + claims team)

---

## 📝 Notities & Context

**Relevante Links:**
- Metabase: http://localhost:3001/dashboard/claims-analysis
- SQL queries: insurance-data/analytics/claims_queries.sql

**Technische Details:**
- Queries: 8 main queries (4 zijn geoptimaliseerd, 4 nog te doen)
- Materialized views: claims_summary_mv, claims_trends_mv
- Refresh schedule: Daily at 02:00 UTC

**Voor bij restart:**
Focus op query optimization voor laatste 4 queries. Check met Janbu of database indexes mogelijk zijn.

---

## 📅 Historie (Laatste 5 Updates)

### 2025-01-05 11:20 - Status: Executing
Bezig met visualisaties toevoegen

### 2025-01-05 09:00 - Status: Executing
Materialized views created voor performance

### 2025-01-04 15:30 - Status: Executing
SQL queries geschreven en getest

### 2025-01-04 10:00 - Status: Planning
Dashboard layout design voltooid

---

**Laatste update door:** Lordi (dat)
**Volgende review:** Vrijdag (na UAT)
```

---

## 🎯 Best Practices

### DO ✅
- **Wees specifiek:** Niet "Bezig met code", maar "Implementing InboxPage fix - useEffect dependency array"
- **Update regelmatig:** Elke 2-3 uur tijdens actief werk
- **Noteer beslissingen:** Waarom koos je deze aanpak? (voor jezelf én anderen)
- **Traceer blockers:** Zodat Team Lead kan helpen
- **Link naar resources:** Code files, commits, issues
- **Bewaar context:** "Voor bij restart" sectie is KEY!

### DON'T ❌
- **Vaag zijn:** "Werken aan project" → wat doe je precies?
- **Te weinig updates:** Alleen bij start en einde → andere agents weten niet wat je doet
- **Geen beslissingen:** Waarom koos je X ipv Y? Documenteer rationale!
- **Geen blockers melden:** Team kan niet helpen als ze niet weten dat je vast zit
- **Geen context voor restart:** Je vergeet morgen waar je was

---

## 🔄 Status Lifecycle

```
Thinking
   │
   ▼
Planning
   │
   ▼
Executing ←─┐
   │        │
   ▼        │ (iteraties)
Testing     │
   │        │
   ▼        │
Review ─────┘
   │
   ├─ Approved → Completed
   └─ Changes requested → Executing
```

---

## 📊 Team Lead Oversight

**Ulle (ATL) checkt regelmatig:**
- Wie is waar mee bezig? (via status files)
- Zijn er blockers? (escaleren naar Frank indien nodig)
- Is er overlap tussen agents? (coördineren)
- Zijn agents on track? (volgens ARCHITECTUUR.md principes)

**Daarom is regelmatig updaten belangrijk!**

---

## 🚨 Escalatie Protocol

### Wanneer escaleren naar Team Lead (ATL)?

1. **Blocker > 4 uur** → Update status naar "Blocked" + ping ATL via team chat
2. **Twijfel over architectuur** → Vraag ATL (liever 10 min overleg dan verkeerd bouwen)
3. **Conflict met ARCHITECTUUR.md** → Check eerst doc, dan ATL
4. **Andere agent niet responsive** → Ping ATL voor follow-up
5. **Scoping issues** → Taak groter dan verwacht? ATL moet weten

**Status file format bij blocker:**
```markdown
**Status:** Blocked

**Blockers:**
- Frank input nodig over deployment environment (wacht >4 uur)
- Escalated naar ATL via team chat op 2025-01-05 16:00
```

---

## 📞 Vragen?

**Check:**
1. Deze `STATUS-PROTOCOL.md` (lees voorbeelden!)
2. `STARTUP-CONTEXT.md` (algemene context)
3. `TEAM-ROSTER.md` (wie doet wat)
4. Team chat (vraag andere agents)
5. Escaleer naar ATL (Ulle)

---

**Versie:** 1.0
**Auteur:** Ulle (AI Team Lead)
**Laatst bijgewerkt:** 2025-01-05

**🎯 "Status updates zijn niet overhead - ze zijn de lijm die het team bij elkaar houdt."**
