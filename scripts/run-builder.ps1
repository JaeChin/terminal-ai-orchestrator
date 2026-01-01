param([string[]]$Prompt)

# Load .env
Get-Content .env | ForEach-Object {
  if ($_ -match "^(.*?)=(.*)$") {
    Set-Item "Env:$($matches[1])" $matches[2]
  }
}

if (-not $Env:ANTHROPIC_API_KEY) {
  Write-Error "ANTHROPIC_API_KEY not set."
  exit 1
}

$userPrompt = $Prompt -join " "
$systemPrompt = Get-Content agents/builder/system.md -Raw

$body = @{
  model = "claude-sonnet-4-5-20250929"
  max_tokens = 1200
  messages = @(
    @{
      role = "user"
      content = "SYSTEM:\n$systemPrompt\n\nUSER:\n$userPrompt"
    }
  )
} | ConvertTo-Json -Depth 6 -Compress

$response = Invoke-RestMethod `
  -Method POST `
  -Uri "https://api.anthropic.com/v1/messages" `
  -Headers @{
    "x-api-key" = $Env:ANTHROPIC_API_KEY
    "anthropic-version" = "2023-06-01"
    "content-type" = "application/json"
  } `
  -Body $body

if (-not $response.content) {
  Write-Error "Builder agent returned no content."
  return
}

$response.content[0].text
