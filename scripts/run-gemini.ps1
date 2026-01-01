param([string[]]$Prompt)

# Load .env
Get-Content .env | ForEach-Object {
  if ($_ -match "^(.*?)=(.*)$") {
    Set-Item "Env:$($matches[1])" $matches[2]
  }
}

if (-not $Env:GEMINI_API_KEY) {
  Write-Error "GEMINI_API_KEY not set."
  exit 1
}

$userPrompt = $Prompt -join " "

$body = @{
  contents = @(
    @{
      parts = @(
        @{ text = $userPrompt }
      )
    }
  )
  generationConfig = @{
    temperature = 0.6
    maxOutputTokens = 1024
  }
} | ConvertTo-Json -Depth 6 -Compress

$uri = "https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent?key=$($Env:GEMINI_API_KEY)"

$response = Invoke-RestMethod -Method POST -Uri $uri -ContentType "application/json" -Body $body

if (-not $response.candidates) {
  Write-Error "Gemini API returned no candidates."
  return
}

$response.candidates[0].content.parts[0].text
