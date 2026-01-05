# Update Agent Prompts with Git Commit Protocol
# Team Franklab - Consistency & Transparency

$promptsPath = "D:\dev\agents\prompts"
$protocolFile = "D:\dev\agents\scripts\git-commit-protocol.md"

# Read the protocol template
$protocol = Get-Content $protocolFile -Raw

Write-Host "Updating agent prompts with Git Commit Protocol..." -ForegroundColor Cyan
Write-Host ""

# Get all markdown files except READ-FIRST and git-commit-protocol
$promptFiles = Get-ChildItem -Path $promptsPath -Filter "*.md" | Where-Object {
    $_.Name -ne "READ-FIRST-AT-STARTUP.md" -and $_.Name -ne "git-commit-protocol.md"
}

foreach ($file in $promptFiles) {
    $content = Get-Content $file.FullName -Raw

    # Check if protocol already exists
    if ($content -match "## Git Commit Protocol") {
        Write-Host "  $($file.Name) already has Git Commit Protocol" -ForegroundColor Green
        continue
    }

    # Append protocol to the end
    $newContent = $content.TrimEnd() + "`r`n`r`n" + $protocol

    Set-Content -Path $file.FullName -Value $newContent -NoNewline

    Write-Host "  Updated $($file.Name)" -ForegroundColor Green
}

Write-Host ""
Write-Host "Git Commit Protocol added to all agent prompts!" -ForegroundColor Green
