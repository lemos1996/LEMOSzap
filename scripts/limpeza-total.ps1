# Script de LIMPEZA TOTAL e BLINDAGEM do LEMOSzap - V2.1
# Este script remove TODAS as referências aos servidores antigos e marcas do WaSeller

$extensionPath = "C:\Users\LEMOS\.gemini\antigravity\scratch\LEMOSzap-github\LEMOSzap-extension"

Write-Host "============================================================"
Write-Host "   LIMPEZA PROFUNDA E BLINDAGEM V2.1 - LEMOSZAP"
Write-Host "============================================================"
Write-Host ""

# Mapeamento de substituições específicas para URLs
$urlReplacements = @{
    "autowebhook.papo.global" = "localhost:5000"
    "wascript.com.br"         = "localhost:5000"
    "waclientes.com.br"       = "localhost:5000"
    "watools.com.br"          = "localhost:5000"
}

$files = Get-ChildItem -Path $extensionPath -Recurse -File -Include *.js, *.json, *.html, *.css, *.txt, *.md

Write-Host "Analizando $($files.Count) arquivos..."

$totalFilesModified = 0

foreach ($file in $files) {
    if ($file.Name -match "limpeza-total.ps1" -or $file.FullName -match "NOVOS_ICONES_LEMOSZAP") {
        continue
    }

    $content = [System.IO.File]::ReadAllText($file.FullName)
    $originalContent = $content
    
    # 1. Substituir domínios específicos
    foreach ($domain in $urlReplacements.Keys) {
        if ($content.Contains($domain)) {
            $content = $content.Replace($domain, $urlReplacements[$domain])
        }
    }
    
    # 2. Substituir variações de nome de marca (Regex Case-Insensitive)
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, "waseller", "lemoszap", "IgnoreCase")
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, "wascript", "lemoszap", "IgnoreCase")
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, "watools", "lemoszap", "IgnoreCase")
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, "waclientes", "lemoszap", "IgnoreCase")
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, "iawascript", "ialemoszap", "IgnoreCase")

    if ($content -ne $originalContent) {
        $relPath = $file.FullName.Replace($extensionPath, "")
        Write-Host "Limpando: $relPath"
        [System.IO.File]::WriteAllText($file.FullName, $content)
        $totalFilesModified++
    }
}

Write-Host ""
Write-Host "============================================================"
Write-Host "   LIMPEZA CONCLUIDA!"
Write-Host "   Arquivos blindados: $totalFilesModified"
Write-Host "============================================================"
Write-Host ""
Write-Host "A extensao agora esta blindada."
