# Script para configurar a URL do servidor na extensão LEMOSzap

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   CONFIGURAÇÃO DE SERVIDOR - LEMOSZAP" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

$extensionPath = "C:\Users\LEMOS\.gemini\antigravity\scratch\LEMOSzap-github\LEMOSzap-extension"
$backgroundPath = "$extensionPath\background.js"

if (-not (Test-Path $backgroundPath)) {
    Write-Host "❌ Arquivo background.js não encontrado!" -ForegroundColor Red
    exit
}

Write-Host "🌐 Onde seu servidor está rodando?" -ForegroundColor Yellow
Write-Host "   (Exemplo: https://lemoszap-server.onrender.com ou http://localhost:5000)" -ForegroundColor Gray
$serverUrl = Read-Host "Digite a URL completa do servidor"

if ($serverUrl -notlike "http*") {
    Write-Host "❌ URL inválida! Deve começar com http:// ou https://" -ForegroundColor Red
    exit
}

# Garantir que termina com barra
if (-not $serverUrl.EndsWith("/")) {
    $serverUrl += "/"
}

Write-Host ""
Write-Host "🔄 Atualizando configuração na extensão..." -ForegroundColor Yellow

$content = Get-Content $backgroundPath -Raw -Encoding UTF8

# Regex para encontrar as URLs no objeto w
$content = $content -replace 'backend_plugin: ".*?"', "backend_plugin: `"$serverUrl`""
$content = $content -replace 'backend: ".*?"', "backend: `"$serverUrl`""
$content = $content -replace 'backend_utils: ".*?"', "backend_utils: `"$serverUrl`""

Set-Content $backgroundPath $content -Encoding UTF8

Write-Host "✅ Configuração atualizada com sucesso!" -ForegroundColor Green
Write-Host "📍 URL definida: $serverUrl" -ForegroundColor Cyan
Write-Host ""
Write-Host "🚀 Agora, quando você subir para o GitHub ou carregar no Chrome," -ForegroundColor White
Write-Host "   a extensão saberá exatamente onde o seu servidor está!" -ForegroundColor White
Write-Host ""
