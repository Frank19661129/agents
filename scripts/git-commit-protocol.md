## Git Commit Protocol

**BELANGRIJK:** Bij elke git commit/PR moet je je agent signature toevoegen.

### Commit Message Format

```
<type>: <short description>

<detailed description>

🤖 <agent-tag>
Co-Authored-By: <agent-name> <agent@franklab.local>
```

### Examples

**Developer Agent (#dev):**
```
feat: Add JWT authentication

- Implemented token generation
- Added login/logout endpoints
- Tests added

🤖 #dev
Co-Authored-By: dev-agent <dev@franklab.local>
```

**Team Lead Agent (#atl):**
```
docs: Update architecture decision for API versioning

- Added ADR-003: API Versioning Strategy
- Decided on /api/v1 pattern
- Updated team-context.md

🤖 #atl
Co-Authored-By: atl-agent <atl@franklab.local>
```

### Commit Types
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `refactor`: Code refactoring
- `test`: Tests
- `chore`: Maintenance

### Issues & PRs

When creating issues or PRs, **always add:**
- Agent label (e.g. `#dev`, `#atl`)
- Priority label (e.g. `P0-Critical`, `P1-High`)
- Type label (e.g. `bug`, `feature`)

**Example issue:**
```bash
gh issue create \
  --repo Frank19661129/franklab \
  --title "Fix inbox loading bug" \
  --label "#dev,P0-Critical,bug" \
  --body "Description...

🤖 Agent: #dev"
```

---

**Git identity is automatically set** when you start via your batch file.
Check with: `git config user.name` (should show your agent name)

## GitHub Authentication (PAT Setup)

**BELANGRIJK:** Configureer ALTIJD de GitHub remote URL met Personal Access Token (PAT) voor automatische push zonder login prompts.

### Waarom?
- Voorkomt login prompts bij elke `git push`
- Veilig (PAT in URL, niet in credentials store)
- Consistent tussen alle projecten

### Setup voor nieuwe repositories:

```bash
# Verkeerde manier (vraagt om login):
git remote add origin https://github.com/Frank19661129/project.git

# Correcte manier (met PAT):
git remote add origin https://ghp_YOUR_PERSONAL_ACCESS_TOKEN_HERE@github.com/Frank19661129/project.git
```

### Fix bestaande repository:

```bash
# Check huidige remote:
git remote -v

# Update remote met PAT:
git remote set-url origin https://ghp_YOUR_PERSONAL_ACCESS_TOKEN_HERE@github.com/Frank19661129/REPO_NAME.git

# Test push:
git push
```

### Verificatie:

Na setup moet `git remote -v` dit tonen:
```
origin  https://ghp_YOUR_PERSONAL_ACCESS_TOKEN_HERE@github.com/Frank19661129/project.git (fetch)
origin  https://ghp_YOUR_PERSONAL_ACCESS_TOKEN_HERE@github.com/Frank19661129/project.git (push)
```

### Voorbeeld uit praktijk:

**Franklab website** (correct):
```
origin  https://ghp_YOUR_PERSONAL_ACCESS_TOKEN_HERE@github.com/Frank19661129/franklab.git
```

**Einsteinpuzzle** (gefixt):
```
origin  https://ghp_YOUR_PERSONAL_ACCESS_TOKEN_HERE@github.com/Frank19661129/Einsteinpuzzle.git
```

### Troubleshooting:

**Symptoom:** `Logon failed, use ctrl+c to cancel basic credential prompt`
**Oplossing:** Remote URL mist PAT, gebruik `git remote set-url` commando hierboven

**Belangrijk:** Dit PAT is project-specifiek voor Frank's repositories. Bij nieuwe organisaties/accounts moet een nieuwe PAT worden aangemaakt via GitHub Settings > Developer settings > Personal access tokens.
