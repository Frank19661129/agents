# Agent Status Directory

**Locatie:** `d:/dev/agents/status/`
**Doel:** Centraal status tracking per project per agent

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

---

## 🚀 Quick Start

### 1. Maak nieuwe status file

```bash
# Kopieer template
cp TEMPLATE_status.md {jouw_project}_{jouw_agent}_status.md

# Voorbeeld:
cp TEMPLATE_status.md pai_dev_status.md
```

### 2. Vul template in

Vervang alle `{placeholders}` met jouw informatie.

### 3. Update regelmatig

Zie `STATUS-PROTOCOL.md` voor update frequentie en best practices.

---

## 📋 Protocol

Zie **`d:/dev/agents/STATUS-PROTOCOL.md`** voor:
- Volledige template uitleg
- Status types (Thinking, Planning, Executing, etc.)
- Update frequentie
- Best practices
- Voorbeelden

---

## 🔍 Status Files Checken

### Als Agent (jezelf)
```bash
# Lees je eigen status
cat d:/dev/agents/status/{jouw_project}_{jouw_agent}_status.md

# Update je status
code d:/dev/agents/status/{jouw_project}_{jouw_agent}_status.md
```

### Als Team Lead (ATL)
```bash
# Zie alle actieve status files
ls d:/dev/agents/status/*_status.md

# Check specifieke agent
cat d:/dev/agents/status/{project}_dev_status.md
```

### Als Andere Agent
```bash
# Check wat Janbu (dev) doet aan PAI
cat d:/dev/agents/status/pai_dev_status.md

# Check alle status files
ls -lah d:/dev/agents/status/
```

---

## 📊 Status Overzicht (Voorbeeld)

Huidige actieve taken:

| File | Agent | Project | Status | Laatst Update |
|------|-------|---------|--------|---------------|
| `pai_dev_status.md` | Janbu | PAI | Executing | 2025-01-05 14:30 |
| `pepper-web_dpl_status.md` | Goof | Pepper-web | Planning | 2025-01-05 16:45 |
| `insurance-data_dat_status.md` | Lordi | Insurance Data | Executing | 2025-01-05 11:20 |

---

## ⚠️ Belangrijk

### DO ✅
- Update status VOOR je restart
- Update status bij belangrijke wijzigingen
- Wees specifiek in beschrijvingen
- Noteer blockers DIRECT
- Bewaar context voor restart

### DON'T ❌
- Vaag zijn ("bezig met code")
- Vergeten te updaten
- Blockers niet melden
- Geen context voor restart

---

## 🗑️ Opruimen

### Voltooide Taken
```bash
# Verplaats naar archive (optioneel)
mkdir -p d:/dev/agents/status/archive
mv {project}_{agent}_status.md archive/

# Of delete (als volledig gedocumenteerd in git commits)
rm {project}_{agent}_status.md
```

### Aanbeveling
- **Keep actieve taken** in `status/`
- **Archive voltooide taken** in `status/archive/`
- **Delete oude archived items** na 30 dagen (indien gewenst)

---

## 📞 Vragen?

1. Lees `STATUS-PROTOCOL.md` (volledig protocol met voorbeelden)
2. Check `TEMPLATE_status.md` (kopieer voor nieuwe file)
3. Vraag Team Lead (ATL) via team chat

---

**Versie:** 1.0
**Laatste update:** 2025-01-05
**Auteur:** Ulle (AI Team Lead)
