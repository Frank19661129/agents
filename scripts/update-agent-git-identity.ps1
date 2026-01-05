# Update Agent Batch Files met Git Identity
# Team Franklab - Agent Git Identity Configuration

$agents = @{
    "atl" = @{ name = "atl-agent"; email = "atl@franklab.local" }
    "dev" = @{ name = "dev-agent"; email = "dev@franklab.local" }
    "rev" = @{ name = "rev-agent"; email = "rev@franklab.local" }
    "tst" = @{ name = "tst-agent"; email = "tst@franklab.local" }
    "arc" = @{ name = "arc-agent"; email = "arc@franklab.local" }
    "doc" = @{ name = "doc-agent"; email = "doc@franklab.local" }
    "dpl" = @{ name = "dpl-agent"; email = "dpl@franklab.local" }
    "sec" = @{ name = "sec-agent"; email = "sec@franklab.local" }
    "ux"  = @{ name = "ux-agent";  email = "ux@franklab.local" }
    "cmp" = @{ name = "cmp-agent"; email = "cmp@franklab.local" }
    "dat" = @{ name = "dat-agent"; email = "dat@franklab.local" }
    "fd"  = @{ name = "fd-agent";  email = "fd@franklab.local" }
    "fin" = @{ name = "fin-agent"; email = "fin@franklab.local" }
    "mon" = @{ name = "mon-agent"; email = "mon@franklab.local" }
    "vc"  = @{ name = "vc-agent";  email = "vc@franklab.local" }
}

$basePath = "D:\dev"

Write-Host "Updating agent batch files with git identity..." -ForegroundColor Cyan

foreach ($agentKey in $agents.Keys) {
    $batFile = Join-Path $basePath "$agentKey.bat"

    if (-not (Test-Path $batFile)) {
        Write-Host "  Skipping $agentKey.bat (not found)" -ForegroundColor Yellow
        continue
    }

    $agent = $agents[$agentKey]
    $content = Get-Content $batFile -Raw

    # Check if git identity already exists
    if ($content -match "git config user\.name") {
        Write-Host "  $agentKey.bat already has git identity" -ForegroundColor Green
        continue
    }

    # Insert git identity after "cd /d D:\dev"
    $gitIdentity = "`r`n`r`n:: Set git identity for this agent`r`ngit config user.name `"$($agent.name)`"`r`ngit config user.email `"$($agent.email)`""

    $content = $content -replace '(cd /d D:\\dev)', "`$1$gitIdentity"

    # Write back
    Set-Content -Path $batFile -Value $content -NoNewline

    Write-Host "  Updated $agentKey.bat" -ForegroundColor Green
}

Write-Host ""
Write-Host "Git identity update complete!" -ForegroundColor Green
