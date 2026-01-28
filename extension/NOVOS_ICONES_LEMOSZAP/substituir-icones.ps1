# Script para substituir os ícones do WaSeller pelos ícones do LEMOSzap
# Execute este script no PowerShell como Administrador

Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  SUBSTITUIÇÃO DE ÍCONES - WASELLER → LEMOSZAP" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# Verificar se o navegador está aberto
Write-Host "⚠️  IMPORTANTE: Feche o Chrome/Edge antes de continuar!" -ForegroundColor Yellow
Write-Host ""
$confirm = Read-Host "O navegador está fechado? (S/N)"

if ($confirm -ne "S" -and $confirm -ne "s") {
    Write-Host "❌ Operação cancelada. Feche o navegador e execute novamente." -ForegroundColor Red
    exit
}

Write-Host ""
Write-Host "🔄 Iniciando substituição dos ícones..." -ForegroundColor Yellow
Write-Host ""

# Definir caminhos
$sourceDir = "D:\extersao zap\LEMOSzap\NOVOS_ICONES_LEMOSZAP"
$targetDir = "D:\extersao zap\LEMOSzap\label\icons\plugin"
$backupDir = "D:\extersao zap\LEMOSzap\BACKUP_ICONES_WASELLER"

# Criar pasta de backup
if (-not (Test-Path $backupDir)) {
    Write-Host "📦 Criando pasta de backup..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $backupDir | Out-Null
}

# Fazer backup dos ícones antigos
Write-Host "💾 Fazendo backup dos ícones antigos do WaSeller..." -ForegroundColor Yellow

try {
    Copy-Item "$targetDir\icon.png" "$backupDir\icon_waseller_backup.png" -Force -ErrorAction Stop
    Copy-Item "$targetDir\logo.png" "$backupDir\logo_waseller_backup.png" -Force -ErrorAction Stop
    Copy-Item "$targetDir\plugin_login.png" "$backupDir\plugin_login_waseller_backup.png" -Force -ErrorAction Stop
    Write-Host "✅ Backup criado em: $backupDir" -ForegroundColor Green
}
catch {
    Write-Host "⚠️  Aviso: Não foi possível fazer backup de alguns arquivos" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎨 Copiando novos ícones do LEMOSzap..." -ForegroundColor Yellow

# Copiar novos ícones
try {
    Copy-Item "$sourceDir\icon.png" "$targetDir\icon.png" -Force -ErrorAction Stop
    Write-Host "  ✅ icon.png copiado" -ForegroundColor Green
    
    Copy-Item "$sourceDir\logo.png" "$targetDir\logo.png" -Force -ErrorAction Stop
    Write-Host "  ✅ logo.png copiado" -ForegroundColor Green
    
    Copy-Item "$sourceDir\plugin_login.png" "$targetDir\plugin_login.png" -Force -ErrorAction Stop
    Write-Host "  ✅ plugin_login.png copiado" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "  ✅ ÍCONES SUBSTITUÍDOS COM SUCESSO!" -ForegroundColor Green
    Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "📋 Próximos passos:" -ForegroundColor Yellow
    Write-Host "   1. Abra o Chrome/Edge" -ForegroundColor White
    Write-Host "   2. Vá para chrome://extensions/ ou edge://extensions/" -ForegroundColor White
    Write-Host "   3. Clique no botão de recarregar da extensão LEMOSzap" -ForegroundColor White
    Write-Host "   4. Verifique se o novo ícone aparece!" -ForegroundColor White
    Write-Host ""
    Write-Host "💾 Backup dos ícones antigos salvo em:" -ForegroundColor Cyan
    Write-Host "   $backupDir" -ForegroundColor White
    Write-Host ""
    
}
catch {
    Write-Host ""
    Write-Host "❌ ERRO ao copiar os arquivos!" -ForegroundColor Red
    Write-Host "   Detalhes: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "💡 Tente executar o PowerShell como Administrador" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

Write-Host "🎉 Processo concluído!" -ForegroundColor Green
Write-Host ""
