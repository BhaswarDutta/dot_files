$ErrorActionPreference = "Stop"

$EXTENSION_FILE = "extension_list.txt"

Clear-Host

Write-Host "=================================="
Write-Host "   VSCode Extension Installer"
Write-Host "=================================="
Write-Host ""
Write-Host "Choose installation target:"
Write-Host ""
Write-Host "  1) Both (default)"
Write-Host "  2) VS Code"
Write-Host "  3) VSCodium"
Write-Host ""

$choice = Read-Host "Selection [1-3]"

if ([string]::IsNullOrWhiteSpace($choice))
{
    $choice = "1"
}

function Install-Extensions
{
    param (
        [string]$Editor
    )

    if (-not (Get-Command $Editor -ErrorAction SilentlyContinue))
    {
        Write-Host ""
        Write-Host "[!] $Editor is not installed."
        return
    }

    Write-Host ""
    Write-Host "Installing extensions for: $Editor"
    Write-Host "----------------------------------"

    Get-Content $EXTENSION_FILE | ForEach-Object {
        $extension = $_.Trim()

        if ($extension -eq "")
        {
            return
        }

        Write-Host "→ $extension"
        & $Editor --install-extension $extension
    }

    Write-Host ""
    Write-Host "[✓] Finished installing for $Editor"
}

switch ($choice)
{
    "1"
    {
        Install-Extensions "code"
        Install-Extensions "codium"
    }

    "2"
    {
        Install-Extensions "code"
    }

    "3"
    {
        Install-Extensions "codium"
    }

    default
    {
        Write-Host ""
        Write-Host "Invalid option."
        exit 1
    }
}

Write-Host ""
Write-Host "Done."
