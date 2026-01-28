# Script para configurar e subir o REPOSITÓRIO ÚNICO LEMOSzap no GitHub
# Execute este script no PowerShell

$basePath = "D:\extersao zap\LEMOSzap-github"
Set-Location $basePath

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   SETUP LEMOSZAP - GITHUB (REPOSITÓRIO ÚNICO)" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se Git está instalado
if (!(git --version)) {
    Write-Host "❌ Git não encontrado! Por favor, instale o Git primeiro." -ForegroundColor Red
    exit
}

# Solicitar informações do usuário
Write-Host "📝 Configuração do GitHub" -ForegroundColor Yellow
$githubUser = Read-Host "Digite seu usuário do GitHub"
$repoName = Read-Host "Digite o nome do repositório (ex: LEMOSzap)"

Write-Host ""
Write-Host "📦 Inicializando repositório Git único..." -ForegroundColor Yellow
git init

# Criar .gitignore básico
@"
*.pyc
__pycache__/
node_modules/
.DS_Store
extension/dist/
server/clientes.json
"@ | Set-Content .gitignore

Write-Host "📝 Adicionando todos os arquivos (Extensão + Servidor + Scripts)..." -ForegroundColor Yellow
git add .

Write-Host "💾 Criando commit inicial..." -ForegroundColor Yellow
git commit -m "🎉 Primeiro commit - Projeto Completo LEMOSzap (Extensão + Servidor)"

Write-Host "🔗 Conectando ao GitHub..." -ForegroundColor Yellow
$remoteUrl = "https://github.com/$githubUser/$repoName.git"
git remote add origin $remoteUrl 2>$null
git remote set-url origin $remoteUrl

Write-Host "🌿 Configurando branch main..." -ForegroundColor Yellow
git branch -M main

Write-Host ""
Write-Host "⚠️  Se for a primeira vez, você precisará autenticar no GitHub." -ForegroundColor Yellow
Write-Host ""

$confirm = Read-Host "Deseja fazer push agora? (S/N)"
if ($confirm -eq "S" -or $confirm -eq "s") {
    Write-Host "🚀 Enviando para o GitHub..." -ForegroundColor Yellow
    git push -u origin main
    Write-Host "✅ Projeto enviado com sucesso para: $remoteUrl" -ForegroundColor Green
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   ✅ SETUP CONCLUÍDO!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
