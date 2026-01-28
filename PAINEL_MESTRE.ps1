# ============================================================
#   PAINEL MESTRE LEMOSZAP - GESTÃO TOTAL
# ============================================================
# Este é o seu centro de controle local.
# Use este painel para gerenciar licenças, servidor e GitHub.

$basePath = $PSScriptRoot
$serverPath = Join-Path $basePath "server"
$dbFile = Join-Path $serverPath "clientes.json"

function Show-Menu {
    Clear-Host
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "         🚀 LEMOSZAP - PAINEL DE CONTROLE MESTRE" -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. [🔑] Ativar/Atualizar Licença Premium"
    Write-Host "2. [🖥️] Iniciar Servidor Local (server.py)"
    Write-Host "3. [🚀] Sincronizar com GitHub (Commit & Push)"
    Write-Host "4. [🛡️] Rodar Blindagem de Marca (Deep Clean)"
    Write-Host "5. [📂] Abrir Pasta do Projeto"
    Write-Host "0. [❌] Sair"
    Write-Host ""
    Write-Host "============================================================"
}

while ($true) {
    Show-Menu
    $choice = Read-Host "Escolha uma opção"

    switch ($choice) {
        "1" {
            Clear-Host
            Write-Host "📝 CADASTRO DE LICENÇA" -ForegroundColor Yellow
            $nome = Read-Host "Nome do Cliente"
            $whatsapp = Read-Host "Número do WhatsApp (ex: 5511999999999)"
            $expiracao = Read-Host "Validade (yyyy-mm-dd - ex: 2027-01-30)"
            
            if ($whatsapp -and $nome) {
                if (!$expiracao) { $expiracao = "2027-01-30" }
                
                $db = if (Test-Path $dbFile) { Get-Content $dbFile | ConvertFrom-Json -AsHashtable } else { @{} }
                
                $db[$whatsapp] = @{
                    "data_registro" = (Get-Date -Format "yyyy-MM-ddTHH:mm:ss")
                    "dados"         = @{
                        "nome"          = $nome
                        "whatsapp"      = $whatsapp
                        "licenca"       = "ATIVA"
                        "Premium ativa" = "sim"
                        "expira_em"     = $expiracao
                    }
                    "status"        = "ativo"
                }
                
                $db | ConvertTo-Json -Depth 10 | Set-Content $dbFile -Encoding UTF8
                Write-Host "✅ Licença ativada com sucesso!" -ForegroundColor Green
            }
            else {
                Write-Host "❌ Dados incompletos!" -ForegroundColor Red
            }
            Pause
        }
        
        "2" {
            Write-Host "🚀 Iniciando Servidor... (Feche a nova janela para parar)" -ForegroundColor Yellow
            Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$serverPath'; python server.py"
            Write-Host "✅ Servidor iniciado em uma nova janela!" -ForegroundColor Green
            Pause
        }
        
        "3" {
            Clear-Host
            Write-Host "🚀 SINCRONIZANDO COM GITHUB" -ForegroundColor Yellow
            $msg = Read-Host "Mensagem das alterações (Enter para padrão)"
            if (!$msg) { $msg = "Atualização via Painel Mestre - $(Get-Date -Format 'dd/MM/yyyy HH:mm')" }
            
            Write-Host "📦 Preparando arquivos..."
            git add .
            Write-Host "💾 Criando commit..."
            git commit -m "$msg"
            Write-Host "📤 Enviando para as nuvens..."
            git push origin main
            Write-Host "✅ Sincronização concluída!" -ForegroundColor Green
            Pause
        }
        
        "4" {
            Write-Host "🛡️ Rodando Blindagem..." -ForegroundColor Yellow
            $cleanScript = Join-Path $basePath "scripts\limpeza-total.ps1"
            if (Test-Path $cleanScript) {
                powershell -ExecutionPolicy Bypass -File $cleanScript
            }
            else {
                Write-Host "❌ Script de limpeza não encontrado!" -ForegroundColor Red
            }
            Pause
        }

        "5" {
            Invoke-Item $basePath
        }
        
        "0" {
            exit
        }
        
        default {
            Write-Host "❌ Opção inválida!" -ForegroundColor Red
            Pause
        }
    }
}
