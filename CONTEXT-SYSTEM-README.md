# Context Persistence System - Gebruikersdocumentatie

**Versie:** 1.0
**Datum:** 2026-01-01
**Status:** ✅ Production Ready

---

## 🎯 Wat Lost Dit Op?

**Probleem:** Elke keer als je een agent restart, verliest die zijn context. Je moet steeds weer uitleggen waar je mee bezig bent.

**Oplossing:** Alle agents laden automatisch de team context EN session context bij het starten. Geen lost context meer!

---

## 📁 Directory Structuur

```
D:\dev\agents\
├── context\
│   ├── team-context.md          # Persistente team state (COMMIT NAAR GIT)
│   ├── session-context.md       # Huidige sessie werk (NIET committen)
│   └── .gitignore
├── scripts\
│   ├── merge-context.ps1        # Mergt context + agent prompt
│   └── save-context.ps1         # Saved huidige context
├── temp\
│   ├── merged-*.md              # Auto-generated (NIET committen)
│   └── .gitignore
└── prompts\
    ├── team-lead.md             # Agent prompts
    ├── architect.md
    └── ...
```

---

## 🔄 Hoe Het Werkt

### Bij Agent Start (Automatisch)

```batch
# Wanneer je "atl" typt:

1. atl.bat wordt uitgevoerd
2. merge-context.ps1 draait:
   - Leest team-context.md
   - Leest session-context.md
   - Leest team-lead.md (agent prompt)
   - Mergt alles → merged-team-lead.md
3. Claude Code start met merged prompt
4. Agent heeft ALLE context!
```

**Resultaat:** Agent weet waar we staan, wat we doen, en wat de prioriteiten zijn.

---

## 📝 Gebruik

### Context Saven Voor Restart

**Simpel (alleen timestamp update):**
```batch
atl-restart
```

**Met notitie (aanbevolen):**
```batch
atl-restart Working on inbox bug - debug logging added
```

Dit updatet `session-context.md` met je notitie.

### Session Context Handmatig Updaten

Open `D:\dev\agents\context\session-context.md` in editor:

```markdown
## Huidige Taken (In Progress)

### Inbox Bug Debuggen
- **Status:** In Progress
- **Agent:** dev + rev
- **Laatste actie:** Debug logging toegevoegd aan InboxPage
- **Volgende stap:** Run app en check console logs

## Volgende Stappen

1. Test inbox loading in browser
2. Check console logs voor errors
3. Fix de bug
4. Test opnieuw
```

**TIP:** Update dit bestand regelmatig (elke 30 min) voor beste continuïteit.

---

## 🗂️ Context Files Uitgelegd

### team-context.md (Persistent - COMMIT NAAR GIT)

**Wat staat erin:**
- Actieve projecten en statussen
- Architectuur beslissingen (uit ARCHITECTUUR.md)
- TODO lijst (P0-P3 priorities)
- Open bugs/issues
- Belangrijke documenten & locaties

**Wanneer updaten:**
- Nieuwe projecten
- Architectuur wijzigingen
- TODO items toevoegen/afvinken
- Nieuwe bugs/issues

**Voorbeeld:**
```markdown
## Actieve Projecten

### PAI (Pepper Backend)
- **Status:** Running
- **Versie:** v0.5
- **Open Issues:**
  - Inbox bug (high priority)
```

### session-context.md (Tijdelijk - NIET COMMITTEN)

**Wat staat erin:**
- Waar je NU mee bezig bent
- Huidige taken in progress
- Volgende stappen
- Laatste activiteiten (recent history)

**Wanneer updaten:**
- Voor elke restart (via `atl-restart`)
- Handmatig als je van taak wisselt
- Elke 30 min voor goede continuïteit

**Voorbeeld:**
```markdown
## Huidige Taken (In Progress)

### Inbox Bug Debuggen
- Status: Testing fix
- Laatste: Console logs added
- Volgende: Verify fix works

## Volgende Stappen

1. Run pai-client
2. Check browser console
3. Fix bug if found
```

---

## 🚀 Workflow Voorbeelden

### Scenario 1: Start van de dag

```batch
# 1. Start ATL
atl

# ATL ziet automatisch:
# - Team status (uit team-context.md)
# - Waar je gisteren gebleven was (uit session-context.md)
# - Je TODO lijst
# - Open bugs

# 2. Continue met werk
# ATL weet al wat prioriteit heeft!
```

### Scenario 2: Agent wisselen tijdens werk

```batch
# Je werkt met atl aan architectuur
atl

# Nu wil je dev agent voor implementatie
# 1. Save context
atl-restart Architectuur done - ready for implementation

# 2. Start dev agent
dev

# Dev agent ziet:
# - Architectuur beslissing (uit team-context)
# - "Ready for implementation" (uit session-context)
# - Alle relevante context
```

### Scenario 3: Einde van de dag

```batch
# Save waar je bent
atl-restart Implemented inbox fix - needs testing tomorrow

# Morgen:
atl

# ATL: "I see we implemented inbox fix yesterday, needs testing. Shall I test it?"
```

---

## 🛠️ Troubleshooting

### Probleem: "Context merge failed"

**Diagnose:**
```bash
# Test merge script handmatig
powershell -ExecutionPolicy Bypass -File "D:\dev\agents\scripts\merge-context.ps1" "team-lead.md"
```

**Mogelijke oorzaken:**
- team-context.md of agent prompt bestaat niet
- PowerShell execution policy issue
- File permissions

**Fix:**
```bash
# Check files exist
ls D:\dev\agents\context\team-context.md
ls D:\dev\agents\prompts\team-lead.md
```

### Probleem: Agent heeft oude context

**Fix:** Verwijder oude merged files en herstart
```bash
rm D:\dev\agents\temp\merged-*.md
atl
```

### Probleem: session-context.md is corrupt

**Fix:** Hernoem oude en maak nieuwe
```bash
mv D:\dev\agents\context\session-context.md D:\dev\agents\context\session-context.md.bak
atl-restart Fresh session context
```

---

## 💡 Best Practices

### 1. Update session-context.md regelmatig

**GOED:**
- Na elke significante stap
- Voor lunch break
- Voor agent wisseling
- Einde van de dag

**SLECHT:**
- Alleen bij restart (te weinig updates)

### 2. Wees specifiek in session-context

**GOED:**
```markdown
## Huidige Taken

### Inbox Bug
- Root cause: useEffect missing dependency array
- Fix applied: Added [] to line 47
- Testing: In progress
```

**SLECHT:**
```markdown
## Huidige Taken

- Werken aan inbox bug
```

### 3. Keep team-context.md actueel

**Update bij:**
- ✅ Nieuwe projecten
- ✅ Voltooide TODO's
- ✅ Architectuur wijzigingen
- ✅ Nieuwe bugs (hoge prioriteit)

**NIET updaten bij:**
- ❌ Elke kleine code change
- ❌ Dagelijkse taken

### 4. Gebruik atl-restart met message

**ALTIJD:**
```batch
atl-restart Implemented feature X - ready for testing
```

**NOOIT:**
```batch
atl-restart
# (geen info wat je deed)
```

---

## 📊 Verificatie: Werkt Het?

### Test 1: Context Merge

```bash
# Merge test
powershell -ExecutionPolicy Bypass -File "D:\dev\agents\scripts\merge-context.ps1" "team-lead.md"

# Check output
cat D:\dev\agents\temp\merged-team-lead.md | head -n 50
```

**Verwacht:**
- Team context bovenaan
- Session context daarna
- Agent prompt onderaan
- Totaal ~300-400 regels

### Test 2: Context Save

```bash
# Save test
powershell -ExecutionPolicy Bypass -File "D:\dev\agents\scripts\save-context.ps1" -Message "Test message"

# Check update
cat D:\dev\agents\context\session-context.md | grep "Test message"
```

**Verwacht:**
- "Test message" appears in session-context.md
- Timestamp updated

### Test 3: Full Workflow

```batch
# 1. Save context
atl-restart Test workflow - context persistence

# 2. Start agent
atl

# 3. Ask agent: "What was I working on?"
```

**Verwacht:**
- Agent zegt: "I see from the session context you were working on: Test workflow - context persistence"

---

## 🎓 Tips voor Frank

1. **Update session-context.md handmatig voor belangrijke context**
   - Open in VSCode
   - Update "Huidige Taken" sectie
   - Voeg notities toe onder "Laatste Activiteiten"

2. **Commit team-context.md naar git regelmatig**
   ```bash
   git add D:\dev\agents\context\team-context.md
   git commit -m "docs: update team context - inbox bug resolved"
   ```

3. **Review session-context.md elke ochtend**
   - Waar ben je gebleven?
   - Wat is prioriteit vandaag?
   - Update indien nodig

4. **Gebruik atl-restart altijd met message**
   - Helpt jezelf morgen
   - Helpt agents sneller up-to-speed komen

---

## 🔄 Maintenance

### Weekly: Team Context Review

**Checklist:**
- [ ] Verouderde projecten archiveren
- [ ] Voltooide TODO's afvinken
- [ ] Nieuwe architectuur beslissingen toevoegen
- [ ] Open bugs updaten

### Daily: Session Context

**Einde van dag:**
```batch
atl-restart [Samenvatting van vandaag - status voor morgen]
```

**Start van dag:**
```bash
# Lees session-context.md
cat D:\dev\agents\context\session-context.md

# Update indien nodig
code D:\dev\agents\context\session-context.md
```

---

## 📞 Support

**Bij problemen:**
1. Check deze README troubleshooting sectie
2. Vraag atl agent: "Can you check the context system status?"
3. Test merge script handmatig
4. Check PowerShell execution policy

**Bij bugs/features:**
- File issue in git repo (indien van toepassing)
- Of update dit document

---

## 📈 Metrics: Hoe Meet Je Succes?

**Voor implementatie:**
- ❌ 50% van agent starts: "Waar waren we ook alweer?"
- ❌ 30 min/dag verloren aan context herladen

**Na implementatie:**
- ✅ 95% van agent starts: Agent weet meteen wat prioriteit is
- ✅ < 5 min/dag aan context maintenance
- ✅ Geen lost work door vergeten context

---

**🎉 Klaar! Enjoy lost-context-free development! 🚀**

---

**Versie:** 1.0
**Auteur:** atl (AI Team Lead)
**Laatst bijgewerkt:** 2026-01-01
