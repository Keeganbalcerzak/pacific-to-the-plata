$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$indexPath = Join-Path $repoRoot "index.html"
$outPath = Join-Path $repoRoot "pacific-to-the-plata.png"

if (-not (Test-Path -LiteralPath $indexPath)) {
  throw "index.html not found at: $indexPath"
}

$edgeCandidates = @(
  Join-Path ${env:ProgramFiles} "Microsoft\Edge\Application\msedge.exe"
  Join-Path ${env:ProgramFiles(x86)} "Microsoft\Edge\Application\msedge.exe"
)
$edge = $edgeCandidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
if (-not $edge) {
  throw "Microsoft Edge not found. Install Edge, or open index.html in a browser and save a screenshot manually."
}

$full = (Get-Item -LiteralPath $indexPath).FullName
$fileUrl = "file:///" + ($full -replace "\\", "/")

$args = @(
  "--headless=new"
  "--disable-gpu"
  "--hide-scrollbars"
  "--window-size=1524,980"
  "--screenshot=$outPath"
  $fileUrl
)

Write-Host "Writing $outPath ..."
& $edge @args
if ($LASTEXITCODE -ne 0) {
  throw "Edge exited with code $LASTEXITCODE"
}

Start-Sleep -Milliseconds 800
if (-not (Test-Path -LiteralPath $outPath)) {
  throw "Screenshot file was not created. Try running this script outside a restricted environment."
}

Write-Host "Done: $outPath"
