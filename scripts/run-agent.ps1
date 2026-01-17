# Run Agent - Unified agent runner for role-based agents
# Usage: ./scripts/run-agent.ps1 -Agent plan -Prompt "I want to build a CRM"
# Usage: ./scripts/run-agent.ps1 plan "I want to build a CRM"

param(
    [Parameter(Position=0)]
    [ValidateSet("plan", "architect", "devsecops", "ui", "review", "debug")]
    [string]$Agent,
    
    [Parameter(Position=1, ValueFromRemainingArguments=$true)]
    [string[]]$Prompt,
    
    [string]$Model = "claude-sonnet-4-5-20250929",
    [int]$MaxTokens = 2000
)

# Show help if no agent specified
if (-not $Agent) {
    Write-Host @"
Terminal AI Orchestrator - Agent Runner

USAGE:
    ./scripts/run-agent.ps1 <agent> <prompt>

AGENTS:
    plan        Requirements gathering, research, blueprints
    architect   System design, tech stack, folder structure
    devsecops   Secure coding, infrastructure, CI/CD
    ui          Frontend styling, components, accessibility
    review      Code review, security audit, best practices
    debug       Systematic troubleshooting, root cause analysis

EXAMPLES:
    ./scripts/run-agent.ps1 plan "I want to build a secure CRM"
    ./scripts/run-agent.ps1 architect "Review this blueprint and design the system"
    ./scripts/run-agent.ps1 review "Check this code for security issues"
    ./scripts/run-agent.ps1 debug "API returns 500 errors intermittently"

OPTIONS:
    -Model      Override model (default: claude-sonnet-4-5-20250929)
    -MaxTokens  Override max tokens (default: 2000)
"@
    exit 0
}

# Load .env file
$envFile = Join-Path $PSScriptRoot "../.env"
if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ($_ -match "^([^#][^=]*)=(.*)$") {
            Set-Item "Env:$($matches[1].Trim())" $matches[2].Trim()
        }
    }
}

# Verify API key
if (-not $Env:ANTHROPIC_API_KEY) {
    Write-Error "ANTHROPIC_API_KEY not set. Add it to .env file."
    exit 1
}

# Load agent system prompt
$agentPath = Join-Path $PSScriptRoot "../agents/$Agent/system.md"
if (-not (Test-Path $agentPath)) {
    Write-Error "Agent not found: $agentPath"
    exit 1
}

$systemPrompt = Get-Content $agentPath -Raw
$userPrompt = $Prompt -join " "

if (-not $userPrompt) {
    Write-Error "No prompt provided. Usage: ./scripts/run-agent.ps1 $Agent `"your prompt here`""
    exit 1
}

# Load context if available
$contextPath = Join-Path $PSScriptRoot "../context/memory.md"
$context = ""
if (Test-Path $contextPath) {
    $context = "`n`n## Context from Previous Sessions:`n" + (Get-Content $contextPath -Raw)
}

# Build request
$body = @{
    model = $Model
    max_tokens = $MaxTokens
    system = $systemPrompt
    messages = @(
        @{ 
            role = "user"
            content = $userPrompt + $context
        }
    )
} | ConvertTo-Json -Depth 6

# Make API request
try {
    $response = Invoke-RestMethod `
        -Uri "https://api.anthropic.com/v1/messages" `
        -Method POST `
        -Headers @{
            "x-api-key" = $Env:ANTHROPIC_API_KEY
            "anthropic-version" = "2023-06-01"
            "content-type" = "application/json"
        } `
        -Body $body
    
    if ($response.content) {
        Write-Host "`n[$($Agent.ToUpper()) AGENT]" -ForegroundColor Cyan
        Write-Host ("=" * 50) -ForegroundColor DarkGray
        Write-Host $response.content[0].text
        Write-Host ("=" * 50) -ForegroundColor DarkGray
    } else {
        Write-Error "Agent returned no content."
    }
} catch {
    Write-Error "API request failed: $_"
    exit 1
}