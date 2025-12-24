$ErrorActionPreference = "Stop"

Write-Host "==============================" -ForegroundColor Cyan
Write-Host " Tauri Mobile Boilerplate - Android Dev" -ForegroundColor Cyan
Write-Host "==============================" -ForegroundColor Cyan

function Require-Command($name) {
  if (-not (Get-Command $name -ErrorAction SilentlyContinue)) {
    Write-Host "Ferramenta ausente para o build: $name" -ForegroundColor Red
    Write-Host "Instale ou adicione '$name' ao PATH e tente novamente." -ForegroundColor Yellow
    exit 1
  }
}

function Require-Env($name) {
  $value = [Environment]::GetEnvironmentVariable($name)
  if ([string]::IsNullOrWhiteSpace([string]$value)) {
    Write-Host "Variavel de ambiente ausente para o build: $name" -ForegroundColor Red
    Write-Host "Defina $name antes de continuar." -ForegroundColor Yellow
    exit 1
  }
}

Require-Command adb
Require-Command npm

Write-Host "Verificando variaveis de ambiente..." -ForegroundColor Yellow
Require-Env "JAVA_HOME"
Require-Env "ANDROID_HOME"
Require-Env "NDK_HOME"

Write-Host "Preparando assets..." -ForegroundColor Yellow
powershell -ExecutionPolicy Bypass -File "$PSScriptRoot\copy-to-dist.ps1"

Write-Host "Iniciando Tauri no dispositivo/emulador..." -ForegroundColor Yellow
npm run android:dev
