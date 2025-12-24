$ErrorActionPreference = "Stop"

Write-Host "==============================" -ForegroundColor Cyan
Write-Host " Tauri Mobile Boilerplate - Setup" -ForegroundColor Cyan
Write-Host "==============================" -ForegroundColor Cyan

function Check($label, $script) {
  try {
    $value = & $script
    Write-Host ("[OK] {0}: {1}" -f $label, $value) -ForegroundColor Green
  } catch {
    Write-Host "[!] $label nao encontrado" -ForegroundColor Yellow
  }
}

Check "Java" { (java -version ) }
Check "Javac" { (javac -version ) }
Check "Android SDK (ANDROID_HOME)" { $env:ANDROID_HOME }
Check "NDK (NDK_HOME)" { $env:NDK_HOME }
Check "Rust" { rustc --version }
Check "Cargo" { cargo --version }
Check "Node" { node --version }
Check "npm" { npm --version }
Check "ADB" { adb version | Select-Object -First 1 }

Write-Host ""; Write-Host "Se algum item estiver faltando, configure as variaveis de ambiente e reinicie o shell." -ForegroundColor White
