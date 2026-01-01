param([string[]]$Prompt)

Get-Content .env | ForEach-Object {
  if ($_ -match "^(.*?)=(.*)$") {
    Set-Item "Env:$($matches[1])" $matches[2]
  }
}

$body = @{
  model = "claude-opus-4-5-20251101"
  max_tokens = 1200
  system = (Get-Content agents/claude/system.md -Raw)
  messages = @(
    @{ role = "user"; content = ($Prompt -join " ") }
  )
} | ConvertTo-Json -Depth 6

$response = Invoke-RestMethod `
  -Uri "https://api.anthropic.com/v1/messages" `
  -Method POST `
  -Headers @{
    "x-api-key" = $Env:ANTHROPIC_API_KEY
    "anthropic-version" = "2023-06-01"
    "content-type" = "application/json"
  } `
  -Body $body

$response.content[0].text
