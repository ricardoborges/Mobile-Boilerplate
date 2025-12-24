$ErrorActionPreference = "Stop"

Write-Host "Preparing dist/ with static assets..." -ForegroundColor Cyan
$dist = "dist"
New-Item -ItemType Directory -Path $dist -Force | Out-Null

$files = @("index.html", "styles.css", "script.js")
foreach ($file in $files) {
  Copy-Item $file -Destination (Join-Path $dist $file) -Force
}

Write-Host "Done. Contents:" -ForegroundColor Green
Get-ChildItem $dist | ForEach-Object {
  Write-Host " - $($_.Name)" -ForegroundColor White
}
