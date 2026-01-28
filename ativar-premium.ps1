# Script de Gerenciamento de Licenças LEMOSzap (Customizado)
# Use este script para ativar o PREMIUM com o formato solicitado

$basePath = "D:\extersao zap\LEMOSzap-github"
$serverPath = Join-Path $basePath "server"
$dbFile = Join-Path $serverPath "clientes.json"

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   GERENCIADOR DE LICENÇAS - LEMOSZAP" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Obter informações
$nome = Read-Host "Digite o Nome do Cliente (ex: teste)"
$whatsapp = Read-Host "Digite o número do WhatsApp (ex: 5511999999999)"
$expiracao = Read-Host "Digite a data de expiração (ex: 2027-01-30)"

if (-not $whatsapp -or -not $nome) {
    Write-Host "❌ Dados inválidos!" -ForegroundColor Red
    exit
}

if (-not $expiracao) { $expiracao = "2027-01-30" }

# 2. Carregar database existente ou criar nova
if (Test-Path $dbFile) {
    $db = Get-Content $dbFile | ConvertFrom-Json -AsHashtable
}
else {
    $db = @{}
}

# 3. Criar/Atualizar cliente no formato solicitado
$cliente = @{
    "data_registro"      = (Get-Date -Format "yyyy-MM-ddTHH:mm:ss")
    "ultima_atualizacao" = (Get-Date -Format "yyyy-MM-ddTHH:mm:ss")
    "dados"              = @{
        "nome"          = $nome
        "whatsapp"      = $whatsapp
        "licenca"       = "ATIVA"
        "Premium ativa" = "sim"
        "expira_em"     = $expiracao
    }
    "status"             = "ativo"
}

$db[$whatsapp] = $cliente

# 4. Salvar no arquivo
$db | ConvertTo-Json -Depth 10 | Set-Content $dbFile -Encoding UTF8

Write-Host ""
Write-Host "✅ SUCESSO! Formato customizado aplicado para: $nome ($whatsapp)" -ForegroundColor Green
Write-Host "🌟 Premium: sim | Expira em: $expiracao" -ForegroundColor Green
Write-Host ""
Write-Host "Instruções:"
Write-Host "1. Certifique-se de que o servidor (D:\extersao zap\LEMOSzap-github\server\server.py) está rodando."
Write-Host "2. Recarregue o WhatsApp Web."
Write-Host "============================================================"
