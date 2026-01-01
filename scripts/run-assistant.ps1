param(
  [Parameter(ValueFromRemainingArguments = $true)]
  [string[]]$Prompt
)

# Load environment variables from .env
if (Test-Path .env) {
  Get-Content .env | ForEach-Object {
    if ($_ -match "^(.*?)=(.*)$") {
      Set-Item -Path "Env:$($matches[1])" -Value $matches[2]
    }
  }
}

if (-not $Env:ANTHROPIC_API_KEY) {
  Write-Error "ANTHROPIC_API_KEY not set. Check your .env file."
  exit 1
}

$inputPrompt = $Prompt -join " "

Write-Host "🤝 Assistant (Claude) running..."
Write-Host "--------------------------------"

claude chat `
  --system ./agents/assistant/system.md `
  --input "$inputPrompt"
