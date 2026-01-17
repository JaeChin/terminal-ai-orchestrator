# Setup Global Claude Commands
# Run this once to make /plan, /architect, /devsecops, /ui, /review, /debug, /commit
# available in ANY project folder.

$ErrorActionPreference = "Stop"

# Config location
$ConfigDir = Join-Path $env:APPDATA "claude"
$CommandsDir = Join-Path $ConfigDir "commands"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SourceDir = Join-Path (Split-Path -Parent $ScriptDir) "global-commands"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Global Claude Commands Setup" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Config location: $ConfigDir"
Write-Host ""

# Create directory
if (-not (Test-Path $CommandsDir)) {
    New-Item -ItemType Directory -Path $CommandsDir -Force | Out-Null
}

# Check if source files exist
if (-not (Test-Path $SourceDir)) {
    Write-Host "ERROR: Source directory not found: $SourceDir" -ForegroundColor Red
    Write-Host ""
    Write-Host "Expected structure:"
    Write-Host "  terminal-ai-orchestrator/"
    Write-Host "    global-commands/"
    Write-Host "      plan.md"
    Write-Host "      architect.md"
    Write-Host "      ..."
    Write-Host "    scripts/"
    Write-Host "      setup-global-commands.ps1  <-- you are here"
    exit 1
}

# Copy commands
Write-Host "Installing commands..."
Get-ChildItem -Path $SourceDir -Filter "*.md" | ForEach-Object {
    Copy-Item $_.FullName -Destination $CommandsDir -Force
    Write-Host ("  > " + $_.Name) -ForegroundColor Green
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Setup Complete!" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Available commands (in any project):"
Write-Host "  /plan       - Requirements, research"
Write-Host "  /architect  - System design"
Write-Host "  /devsecops  - Secure implementation"
Write-Host "  /ui         - Frontend, styling"
Write-Host "  /review     - Code review"
Write-Host "  /debug      - Troubleshooting"
Write-Host "  /commit     - Git commit"
Write-Host ""
Write-Host "Start Claude Code in any folder and use these commands."