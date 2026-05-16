# =========================================================
# PowerShell Profile
# =========================================================
# Tools:
# - fastfetch  : system info
# - starship   : prompt
# - zoxide     : smarter cd
# - eza        : modern ls replacement
# - yazi       : terminal file manager
# =========================================================


# =========================================================
# Startup
# =========================================================

# Show system info on shell launch
fastfetch


# =========================================================
# Simple Aliases
# =========================================================

# Linux-style aliases
Set-Alias touch New-Item
Set-Alias cat bat


# =========================================================
# eza (Modern ls)
# =========================================================

# Remove default PowerShell ls alias
Remove-Item Alias:ls -ErrorAction SilentlyContinue


# Compact directory listing
function ls
{
    eza `
        --icons=always `
        -a `
        --group-directories-first `
        @args
}


# Detailed directory listing
function ll
{
    eza `
        --icons=always `
        -a `
        -l `
        -h `
        --group-directories-first `
        @args
}


# Tree view
function lt
{
    eza `
        --icons=always `
        --tree `
        --level=2 `
        --group-directories-first `
        @args
}


# =========================================================
# Yazi File Manager
# =========================================================

# Open Yazi and automatically cd into
# the last visited directory after exit
function y
{
    $tmp = (New-TemporaryFile).FullName

    yazi.exe $args --cwd-file="$tmp"

    $cwd = Get-Content -Path $tmp -Encoding UTF8

    if (
        $cwd -and
        $cwd -ne $PWD.Path -and
        (Test-Path -LiteralPath $cwd -PathType Container)
    )
    {
        Set-Location -LiteralPath (
            Resolve-Path -LiteralPath $cwd
        ).Path
    }

    Remove-Item -Path $tmp
}


# =========================================================
# zoxide (Smarter cd)
# =========================================================

# Replace `cd` with zoxide smart navigation
Invoke-Expression (& {
        (zoxide init powershell --cmd cd | Out-String)
    })


# =========================================================
# Starship Prompt
# =========================================================

# Initialize Starship prompt
Invoke-Expression (&starship init powershell)
