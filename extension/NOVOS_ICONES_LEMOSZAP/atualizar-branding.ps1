# Script para atualizar TODO o branding do WaSeller para LEMOSzap
# Execute este script no PowerShell como Administrador

Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  ATUALIZAÇÃO DE BRANDING - WASELLER → LEMOSZAP" -ForegroundColor Cyan
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

$baseDir = "D:\extersao zap\LEMOSzap"

Write-Host ""
Write-Host "🔄 Iniciando atualização de arquivos..." -ForegroundColor Yellow

# 1. Atualizar manifest.json
$manifestPath = "$baseDir\manifest.json"
if (Test-Path $manifestPath) {
    Write-Host "📝 Atualizando manifest.json..." -ForegroundColor Yellow
    $content = Get-Content $manifestPath -Raw -Encoding UTF8
    $content = $content -replace 'WaSeller - Perder vendas no WhatsApp não é normal', 'LEMOSzap - CRM para WhatsApp Web'
    $content = $content -replace 'waSeller é um CRM para WhatsApp Web', 'LEMOSzap é um CRM completo para WhatsApp Web'
    $content = $content -replace 'label/css/waseller.css', 'label/css/lemoszap.css'
    Set-Content $manifestPath $content -Encoding UTF8
    Write-Host "  ✅ manifest.json atualizado" -ForegroundColor Green
}

# 2. Atualizar label/config/utils.json
$utilsPath = "$baseDir\label\config\utils.json"
if (Test-Path $utilsPath) {
    Write-Host "📝 Atualizando utils.json..." -ForegroundColor Yellow
    $content = Get-Content $utilsPath -Raw -Encoding UTF8
    $content = $content -replace '"nameID": "waseller"', '"nameID": "lemoszap"'
    $content = $content -replace '"name":"WaSeller - Perder vendas no WhatsApp não é normal"', '"name":"LEMOSzap - CRM para WhatsApp Web"'
    $content = $content -replace '"primeiroNome": "WaSeller"', '"primeiroNome": "LEMOSzap"'
    $content = $content -replace '"descricao":"waSeller é um CRM para WhatsApp Web', '"descricao":"LEMOSzap é um CRM completo para WhatsApp Web'
    Set-Content $utilsPath $content -Encoding UTF8
    Write-Host "  ✅ utils.json atualizado" -ForegroundColor Green
}

# 3. Criar lemoszap.css (ou renomear se possível)
$oldCss = "$baseDir\label\css\waseller.css"
$newCss = "$baseDir\label\css\lemoszap.css"
if (Test-Path $oldCss) {
    Write-Host "🎨 Atualizando CSS..." -ForegroundColor Yellow
    $cssContent = @'
:root {
    --primaria: #25D366;
    --secundaria: #1B2845;
    --terciaria: #95E1D3;
    --letra: #fff;
}

.dark {
    --primaria: #25D366;
    --secundaria: #1B2845;
    --terciaria: #95E1D3;
    --letra: #fff;
}
'@
    Set-Content $newCss $cssContent -Encoding UTF8
    Write-Host "  ✅ lemoszap.css criado com novas cores" -ForegroundColor Green
}

# 4. Atualizar background.js (Opcional, mas recomendado para consistência)
$bgPath = "$baseDir\background.js"
if (Test-Path $bgPath) {
    Write-Host "📝 Atualizando background.js..." -ForegroundColor Yellow
    $content = Get-Content $bgPath -Raw -Encoding UTF8
    $content = $content -replace 'name: "watidy"', 'name: "lemoszap"'
    Set-Content $bgPath $content -Encoding UTF8
    Write-Host "  ✅ background.js atualizado" -ForegroundColor Green
}

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  ✅ BRANDING ATUALIZADO COM SUCESSO!" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "📋 Próximos passos:" -ForegroundColor Yellow
Write-Host "   1. Abra o Chrome/Edge" -ForegroundColor White
Write-Host "   2. Vá para chrome://extensions/" -ForegroundColor White
Write-Host "   3. Clique no botão de atualizar (recarregar) a extensão" -ForegroundColor White
Write-Host "   4. Agora você verá o nome 'LEMOSzap' e o novo ícone!" -ForegroundColor White
Write-Host ""

Write-Host "🎉 Processo concluído!" -ForegroundColor Green
Write-Host ""
