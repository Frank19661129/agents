# Franklab - Architecture Documentation Index

**Versie:** 1.1
**Datum:** 2026-01-06
**Doel:** Centraal overzicht van alle architectuur documenten

---

## 🎯 Single Source of Truth

### ⭐ ARCHITECTUUR.md (LEIDEND!)
**Locatie:** `d:/dev/ARCHITECTUUR.md`
**Versie:** 1.1 (Updated: 2026-01-06)

**Dit is het LEIDENDE document** voor alle Franklab projecten.

**Bevat:**
- Architectuur principes (Design First, API First, etc.)
- **NIEUW**: Single Source of Truth principe ("Wegen naar Rome")
- Tech stack beslissingen (FastAPI, React, Flutter, PostgreSQL)
- Standaarden per agent domein (Architect, Developer, DevOps, etc.)
- Testing strategie (Testing Pyramid, 80% coverage)
- Logging & Monitoring standaarden
- Error handling patterns
- API standards (versioning, auth, rate limiting)
- Security standards (OWASP Top 10)
- CI/CD pipeline templates
- Database naming conventions
- TODO items (P0-P3 prioriteiten)

**Recent Update (2026-01-06):**
- ✨ Added Principle #7: "Single Source of Truth" (Wegen naar Rome)
  - No business logic duplication
  - Multiple entry points → 1 central pipeline
  - Real example: insurance-data DocumentProcessingService saved 175 LOC (-68%)
  - Prevents: bug fixed in 1 place, still exists in 3 others

**Wanneer gebruiken:**
- ✅ Bij ELKE architectuur beslissing
- ✅ Bij twijfel over tech stack
- ✅ Bij nieuwe features (check principes!)
- ✅ Bij code review (check standaarden)

---

## 📚 Project-Specifieke Architectuur

### PAI (Pepper Backend)

#### PAI Main Architecture
**Locatie:** `d:/dev/pai/ARCHITECTURE.md`

**Bevat:**
- PAI backend architectuur overview
- Component diagram
- Database schema (ERD)
- API endpoints overzicht
- Integration patterns

#### PAI Client (Pepper-web) Architecture
**Locatie:** `d:/dev/pai/pai-client/ARCHITECTURE.md`

**Bevat:**
- React app architectuur
- Component hierarchy
- State management (Zustand)
- API integration patterns
- Routing structure

#### Claudine Mobile Events Architecture
**Locatie:** `d:/dev/pai/CLAUDINE_MOBILE_ARCHITECTURE.md`

**Bevat:**
- Mobile event system design
- WebSocket communication
- Real-time updates architecture

---

### Insurance Data Platform

#### Insurance Data Architecture
**Locatie:** `d:/dev/insurance-data/frontend/ARCHITECTURE.md`

**Bevat:**
- Insurance platform architectuur
- Frontend component design
- Backend integration

#### Backend Architecture Review
**Locatie:** `d:/dev/insurance-data/docs/reviews/backend-architecture-review.md`

**Bevat:**
- Backend architectuur review
- Improvement recommendations
- Technical debt items

---

### Claudine (Te Hernoemen naar Pepper)

#### Claudine Design Architecture
**Locatie:** `d:/dev/Claudine/design/MOBILE_EVENTS_ARCHITECTURE.md`

**Bevat:**
- Mobile events design
- Event-driven architecture patterns

---

### Franklab Team Tracking

#### Team Tracking Architecture
**Locatie:** `d:/dev/franklab/team-tracking/ARCHITECTURE.md`

**Bevat:**
- Team tracking system design
- Agent activity tracking
- Real-time chat architecture
- API design

---

## 🗺️ Migratie & Planning Documenten

### WSL → Windows Migratie Plan
**Locatie:** `d:/dev/MIGRATIE-PLAN-WINDOWS.md`

**Bevat:**
- Migratie strategie van WSL naar Windows
- Tool installaties (Docker, Node.js, Flutter)
- Environment setup
- Migration checklist

### Agentic Team Implementatie Plan
**Locatie:** `d:/dev/AGENTIC-TEAM-IMPLEMENTATIEPLAN.md`

**Bevat:**
- AI agent team setup
- Agent rollen & verantwoordelijkheden
- Workflow patterns
- Integration strategie

---

## 📋 Agent Context Documenten

### Team Roster
**Locatie:** `d:/dev/agents/TEAM-ROSTER.md`

**Bevat:**
- Alle agent profielen
- Agent expertise gebieden
- Agent selectie matrix
- Workflow patterns

### Startup Context
**Locatie:** `d:/dev/agents/STARTUP-CONTEXT.md`

**Bevat:**
- Context voor alle agents bij startup
- Team overzicht
- Actieve projecten
- TODO prioriteiten
- Kernwaarden & principes

### Status Protocol
**Locatie:** `d:/dev/agents/STATUS-PROTOCOL.md`

**Bevat:**
- Status update format (`project_agent_status.md`)
- Update frequentie
- Best practices
- Voorbeelden

### Context System README
**Locatie:** `d:/dev/agents/CONTEXT-SYSTEM-README.md`

**Bevat:**
- Context persistence system uitleg
- Hoe team-context.md en session-context.md werken
- Merge-context.ps1 script uitleg
- Troubleshooting

---

## 🔄 Hoe Documenten te Gebruiken

### Bij Nieuwe Feature Development

```
1. LEES: d:/dev/ARCHITECTUUR.md
   └─ Check tech stack, principes, standaarden

2. LEES: Project-specifieke ARCHITECTURE.md
   └─ Begrijp huidige systeem design

3. PLAN: Design volgens ARCHITECTUUR.md principes
   └─ API First, Clean Architecture, etc.

4. REVIEW: Met ATL (Team Lead)
   └─ Ensure alignment met ARCHITECTUUR.md

5. BUILD: Volgens standaarden
   └─ Code style, testing, error handling

6. DOCUMENT: Update project ARCHITECTURE.md indien nodig
   └─ Nieuwe components, API endpoints, etc.
```

### Bij Architectuur Beslissingen

```
1. CHECK: d:/dev/ARCHITECTUUR.md
   └─ Is er al een standaard/beslissing?

2. IF NOT COVERED:
   └─ Escaleer naar ATL (Team Lead)
   └─ Bespreek rationale
   └─ Document beslissing in ADR (Architecture Decision Record)

3. UPDATE: ARCHITECTUUR.md (via PR)
   └─ Nieuwe standaard toevoegen
   └─ Rationale documenteren

4. COMMUNICATE: Naar team
   └─ Via team chat
   └─ Update team-context.md
```

### Bij Code Review

```
1. CHECK CODE TEGEN:
   └─ d:/dev/ARCHITECTUUR.md (standaarden per agent domein)

2. VERIFY:
   ✅ Tech stack correct? (FastAPI, React, etc.)
   ✅ API First principle toegepast?
   ✅ Error handling volgens pattern?
   ✅ Tests ≥ 80% coverage?
   ✅ Security checklist (OWASP)?
   ✅ Naming conventions?

3. IF ISSUES:
   └─ Request changes
   └─ Link naar relevante ARCHITECTUUR.md sectie
```

---

## 📊 Document Ownership

| Document Type | Owner | Update Frequentie | Review |
|---------------|-------|-------------------|--------|
| **ARCHITECTUUR.md** | ATL + Frank | Bij nieuwe standaard | Team Lead |
| **Project ARCHITECTURE.md** | ARC (ATL) | Bij arch changes | Team Lead |
| **TEAM-ROSTER.md** | ATL | Bij team changes | Team Lead |
| **STARTUP-CONTEXT.md** | ATL | Weekly review | Team Lead |
| **STATUS-PROTOCOL.md** | ATL | Bij proces changes | Team Lead |
| **team-context.md** | Alle agents | Bij project updates | Team Lead |
| **session-context.md** | Alle agents | Voor elke restart | N/A (volatile) |
| **Agent status files** | Individuele agents | Elke 2-3 uur | Team Lead |

---

## 🔍 Document Zoeken

### By Topic

| Topic | Document |
|-------|----------|
| **Tech Stack** | ARCHITECTUUR.md (sectie: Tech Stack Decisions) |
| **API Design** | ARCHITECTUUR.md (sectie: API Standards) |
| **Security** | ARCHITECTUUR.md (sectie: Security Standards) |
| **Testing** | ARCHITECTUUR.md (sectie: Testing Strategie) |
| **CI/CD** | ARCHITECTUUR.md (sectie: CI/CD Pipeline) |
| **Database** | ARCHITECTUUR.md (sectie: Database Naming Conventions) |
| **Error Handling** | ARCHITECTUUR.md (sectie: Error Handling) |
| **Logging** | ARCHITECTUUR.md (sectie: Logging & Monitoring) |
| **Agent Profielen** | TEAM-ROSTER.md |
| **Status Format** | STATUS-PROTOCOL.md |
| **Team Workflow** | STARTUP-CONTEXT.md |
| **PAI Architecture** | d:/dev/pai/ARCHITECTURE.md |
| **Pepper-web Architecture** | d:/dev/pai/pai-client/ARCHITECTURE.md |

### By Agent Role

| Agent | Belangrijkste Documenten |
|-------|--------------------------|
| **ATL (Team Lead)** | ARCHITECTUUR.md, TEAM-ROSTER.md, alle project ARCHITECTURE.md |
| **ARC (Architect)** | ARCHITECTUUR.md (Architect sectie), project ARCHITECTURE.md |
| **DEV (Developer)** | ARCHITECTUUR.md (Developer sectie), project ARCHITECTURE.md |
| **DPL (DevOps)** | ARCHITECTUUR.md (Deployment sectie), CI/CD templates |
| **TST (Testing)** | ARCHITECTUUR.md (Testing sectie) |
| **SEC (Security)** | ARCHITECTUUR.md (Security sectie) |
| **DOC (Documentation)** | Alle documenten (voor updates) |

---

## ⚠️ Document Sync Issues

### Conflict Tussen Documenten?

**Prioriteit volgorde (hoogste eerst):**

1. **ARCHITECTUUR.md** ← Single source of truth
2. **Project-specific ARCHITECTURE.md** ← Project details
3. **Agent prompts** ← Agent specific guidance
4. **Andere docs**

**Bij conflict:**
```
1. ARCHITECTUUR.md wint ALTIJD
2. Update conflicterende documenten
3. Escaleer naar ATL indien onduidelijk
```

### Verouderde Documenten?

**Signalen dat document update nodig heeft:**
- ❌ Technologie genoemd die niet meer gebruikt wordt
- ❌ Proces beschreven dat niet meer klopt
- ❌ Links naar niet-bestaande files
- ❌ Laatste update > 3 maanden geleden

**Actie:**
```
1. Create issue/ticket "Update [document naam]"
2. Tag ATL voor review
3. Update document via PR
4. Get approval van Team Lead
5. Merge & communicate changes
```

---

## 📝 Document Update Protocol

### Adding New Architecture Document

```bash
# 1. Create document in juiste locatie
# Project-specific: d:/dev/{project}/ARCHITECTURE.md
# Agent-specific: d:/dev/agents/{document-name}.md

# 2. Update deze index
# Add entry in relevante sectie

# 3. Create PR
git add .
git commit -m "docs: add {document-name} architecture document"
git push

# 4. Request review van ATL
# Via GitHub PR of team chat

# 5. Update cross-references
# Update STARTUP-CONTEXT.md of TEAM-ROSTER.md indien relevant
```

### Updating Existing Document

```bash
# 1. Update document
code d:/dev/{path-to-document}

# 2. Update "Laatst bijgewerkt" datum
# In document header

# 3. Add entry in changelog (indien document heeft changelog)

# 4. Commit met duidelijke message
git commit -m "docs({scope}): {wat je wijzigde en waarom}"

# 5. Notify team (indien breaking change)
# Via team chat indien wijziging impact heeft op workflow
```

---

## 🎯 Best Practices

### DO ✅
- **Lees ARCHITECTUUR.md VOOR je start** met nieuwe feature
- **Check project ARCHITECTURE.md** voor specifieke details
- **Update documenten** als je architectuur wijzigingen maakt
- **Link naar documenten** in code comments waar relevant
- **Houd documenten in sync** (geen conflicten!)

### DON'T ❌
- **Negeer ARCHITECTUUR.md** en doe je eigen ding
- **Verouderde documenten** laten staan (update of delete!)
- **Conflicterende informatie** in verschillende documenten
- **Nieuwe architectuur** zonder documentatie
- **Belangrijke beslissingen** niet documenteren

---

## 📞 Vragen?

**Bij vragen over:**
- **Architectuur beslissingen** → Check ARCHITECTUUR.md, escaleer naar ATL
- **Project specifics** → Check project ARCHITECTURE.md
- **Agent workflow** → Check TEAM-ROSTER.md, STARTUP-CONTEXT.md
- **Document updates** → Tag ATL in PR of team chat

---

**Versie:** 1.0
**Auteur:** Ulle (AI Team Lead)
**Laatst bijgewerkt:** 2025-01-05

**🎯 "Goede documentatie is de tweede-beste vorm van communicatie na daadwerkelijk praten."**
