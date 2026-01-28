# Script de LIMPEZA do LEMOSzap no DRIVE D:
# Este script remove TODAS as referências aos servidores antigos no projeto original

$extensionPath = "D:\extersao zap\LEMOSzap"

Write-Host "============================================================"
Write-Host "   LIMPANDO PROJETO NO DRIVE D: - LEMOSZAP"
Write-Host "============================================================"

# Mapeamento de substituições
$urlReplacements = @{
    "backend-plugin.wascript.com.br"    = "localhost:5000"
    "painel-old.wascript.com.br"        = "localhost:5000"
    "backend-utils.wascript.com.br"     = "localhost:5000"
    "multi-atendimento.wascript.com.br" = "localhost:5000"
    "api-whatsapp.wascript.com.br"      = "localhost:5000"
    "painel.waclientes.com.br"          = "localhost:5000"
    "audio-transcriber.wascript.com.br" = "localhost:5000"
    "painel-new.wascript.com.br"        = "localhost:5000"
    "autowebhook.papo.global"           = "localhost:5000"
    "wascript.com.br"                   = "localhost:5000"
    "waclientes.com.br"                 = "localhost:5000"
    "watools.com.br"                    = "localhost:5000"
    "waseller.com.br"                   = "localhost:5000"
}

$files = Get-ChildItem -Path $extensionPath -Recurse -File -Include *.js, *.json, *.html, *.css, *.txt, *.md

Write-Host "Processando $($files.Count) arquivos..."

$totalFilesModified = 0

foreach ($file in $files) {
    # Evitar loops infinitos ou arquivos desnecessários
    if ($file.FullName -match "BACKUP_ICONES_WASELLER") { continue }

    $content = [System.IO.File]::ReadAllText($file.FullName)
    $originalContent = $content
    
    # 1. Substituir domínios específicos
    foreach ($domain in $urlReplacements.Keys) {
        if ($content.Contains($domain)) {
            $content = $content.Replace($domain, $urlReplacements[$domain])
        }
    }
    
    # 2. Substituir nomes de marca
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, "waseller", "lemoszap", "IgnoreCase")
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, "watidy", "lemoszap", "IgnoreCase")

    if ($content -ne $originalContent) {
        [System.IO.File]::WriteAllText($file.FullName, $content)
        $totalFilesModified++
    }
}

Write-Host "============================================================"
Write-Host "   LIMPEZA CONCLUIDA NO DRIVE D!"
Write-Host "   Arquivos alterados: $totalFilesModified"
Write-Host "============================================================"
