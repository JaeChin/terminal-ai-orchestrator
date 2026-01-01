param([string[]]$Prompt)

Get-Content .env | ForEach-Object {
  if ($_ -match "^(.*?)=(.*)$") {
    Set-Item "Env:$($matches[1])" $matches[2]
  }
}

$messages = @(
  @{ role = "system"; content = (Get-Content agents/chatgpt/system.md -Raw) }
  @{ role = "user"; content = ($Prompt -join " ") }
)

$body = @{
  model = "gpt-4.1"
  messages = $messages
  temperature = 0.4
} | ConvertTo-Json -Depth 6

$response = Invoke-RestMethod `
  -Uri "https://api.openai.com/v1/chat/completions" `
  -Method POST `
  -Headers @{
    "Authorization" = "Bearer $Env:OPENAI_API_KEY"
    "Content-Type" = "application/json"
  } `
  -Body $body

$response.choices[0].message.content
