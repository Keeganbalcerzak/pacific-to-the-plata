$ErrorActionPreference = "Stop"

function Assert-Contains {
  param(
    [string]$Content,
    [string]$Needle,
    [string]$Message
  )

  if (-not $Content.Contains($Needle)) {
    throw $Message
  }
}

$indexPath = Join-Path $PSScriptRoot "..\index.html"
if (-not (Test-Path $indexPath)) {
  throw "index.html does not exist"
}

$html = Get-Content -Raw $indexPath

@(
  "Pacific to the Plata",
  "A South America Overland Route",
  "Valparaiso",
  "Santiago",
  "Mendoza",
  "Cafayate",
  "Salta",
  "Quebrada de Humahuaca",
  "Cordoba",
  "Buenos Aires",
  "Montevideo",
  "Andes bus crossing",
  "9 stops",
  "3 countries",
  "@media print",
  "@media (max-width: 980px)",
  "role=""img""",
  "aria-labelledby=""map-title map-desc""",
  "data-stop=""montevideo"""
) | ForEach-Object {
  Assert-Contains -Content $html -Needle $_ -Message "Missing required content: $_"
}

$stopCount = ([regex]::Matches($html, '<g class="stop" data-stop=')).Count
if ($stopCount -ne 9) {
  throw "Expected 9 SVG stop markers, found $stopCount"
}

"Map verification passed."
