# ===== Portfolio CV Setup Script (PowerShell) =====
# Modern Windows Setup (Windows 7+)
# For better experience, run: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

$ErrorActionPreference = "Stop"

# Colors
$Colors = @{
    Green   = "Green"
    Red     = "Red"
    Yellow  = "Yellow"
    Cyan    = "Cyan"
    Magenta = "Magenta"
}

function Write-Header {
    Write-Host ""
    Write-Host "╔════════════════════════════════════╗" -ForegroundColor Magenta
    Write-Host "║  🎮 Portfolio CV Setup 🎮         ║" -ForegroundColor Magenta
    Write-Host "║  Windows PowerShell Edition        ║" -ForegroundColor Magenta
    Write-Host "╚════════════════════════════════════╝" -ForegroundColor Magenta
    Write-Host ""
}

function Write-Section {
    param([string]$Title)
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
    Write-Host $Title -ForegroundColor Yellow
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}

function Test-Email {
    param([string]$Email)
    return $Email -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
}

function Test-Domain {
    param([string]$Domain)
    return $Domain -match '^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*(\.[a-zA-Z]{2,})?$'
}

function Get-UserInput {
    param(
        [string]$Prompt,
        [string]$Default,
        [string]$Validator = "None"
    )
    
    while ($true) {
        $input = Read-Host "$Prompt [$Default]"
        
        if ([string]::IsNullOrWhiteSpace($input)) {
            return $Default
        }
        
        switch ($Validator) {
            "Email" {
                if (Test-Email $input) {
                    return $input
                } else {
                    Write-Host "✗ Invalid email format" -ForegroundColor Red
                }
            }
            "Domain" {
                if (Test-Domain $input) {
                    return $input
                } else {
                    Write-Host "✗ Invalid domain format" -ForegroundColor Red
                }
            }
            "MinLength2" {
                if ($input.Length -ge 2) {
                    return $input
                } else {
                    Write-Host "✗ Must be at least 2 characters" -ForegroundColor Red
                }
            }
            default {
                return $input
            }
        }
    }
}

# Main Script
Write-Header

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$LayoutFile = Join-Path $ScriptDir "layouts\index.html"
$BackupFile = Join-Path $ScriptDir "layouts\index.html.backup.$(Get-Random)"

# Verify layout file exists
if (-not (Test-Path $LayoutFile)) {
    Write-Host "✗ Error: layouts\index.html not found" -ForegroundColor Red
    exit 1
}

# Create backup
Write-Host "📋 Creating backup..." -ForegroundColor Cyan
Copy-Item $LayoutFile $BackupFile
Write-Host "✓ Backup created: $BackupFile" -ForegroundColor Green
Write-Host ""

# Gather user information
Write-Section "Personal Information"
Write-Host "(Press Enter to skip a field)" -ForegroundColor Yellow
Write-Host ""

$FullName = Get-UserInput "👤 Full Name" "YOUR NAME HERE" "MinLength2"
$Email = Get-UserInput "📧 Email Address" "your@email.com" "Email"
$Domain = Get-UserInput "🌐 Domain/Website" "yourdomain.com" "Domain"

Write-Host ""
Write-Section "Social Media Profiles"
Write-Host "(Optional - press Enter to skip)" -ForegroundColor Yellow
Write-Host ""

$GitHubUser = Get-UserInput "🐙 GitHub username" "yourprofile"
$TwitterHandle = Get-UserInput "𝕏 Twitter/X handle" "yourhandle"
$LinkedInProfile = Get-UserInput "💼 LinkedIn profile" "yourprofile"

# Display summary
Write-Host ""
Write-Section "📝 Summary of Changes"
Write-Host ""
Write-Host "Name:              $FullName" -ForegroundColor Cyan
Write-Host "Email:             $Email" -ForegroundColor Cyan
Write-Host "Domain:            $Domain" -ForegroundColor Cyan
Write-Host "GitHub:            $GitHubUser" -ForegroundColor Cyan
Write-Host "Twitter:           $TwitterHandle" -ForegroundColor Cyan
Write-Host "LinkedIn:          $LinkedInProfile" -ForegroundColor Cyan
Write-Host ""

$Confirm = Read-Host "Proceed with updates? (y/n)"
if ($Confirm -notmatch '^[Yy]$') {
    Write-Host "✗ Setup cancelled" -ForegroundColor Red
    Remove-Item $BackupFile -Force
    exit 1
}

# Apply replacements
Write-Host ""
Write-Host "🔄 Updating files..." -ForegroundColor Cyan

try {
    $Content = Get-Content $LayoutFile -Raw
    
    $Content = $Content -replace 'YOUR NAME HERE', $FullName
    $Content = $Content -replace 'your@email.com', $Email
    $Content = $Content -replace 'yourdomain\.com', $Domain
    $Content = $Content -replace 'yourprofile', $GitHubUser
    $Content = $Content -replace 'yourhandle', $TwitterHandle
    $Content = $Content -replace 'Portfolio Owner', $FullName
    
    Set-Content $LayoutFile $Content -Encoding UTF8
    Write-Host "✓ File updated successfully" -ForegroundColor Green
} catch {
    Write-Host "✗ Error updating file: $_" -ForegroundColor Red
    Write-Host "Restoring backup..." -ForegroundColor Yellow
    Copy-Item $BackupFile $LayoutFile -Force
    exit 1
}

# Rebuild Hugo
Write-Host "🔨 Rebuilding Hugo site..." -ForegroundColor Cyan
if (Get-Command hugo -ErrorAction SilentlyContinue) {
    Push-Location $ScriptDir
    & hugo 2>&1 | Select-String -Pattern "Total|Pages" -ErrorAction SilentlyContinue
    Pop-Location
    Write-Host "✓ Build complete" -ForegroundColor Green
} else {
    Write-Host "⚠ Hugo not found in PATH" -ForegroundColor Yellow
    Write-Host "Install Hugo from: https://gohugo.io/installation/" -ForegroundColor Cyan
}

# Success message
Write-Host ""
Write-Host "╔════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "✓ Setup Complete!" -ForegroundColor Green -BackgroundColor Black
Write-Host "╚════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""

Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Start dev server:  " -NoNewline
Write-Host "hugo server" -ForegroundColor Yellow
Write-Host "  2. Visit:            " -NoNewline
Write-Host "http://localhost:1313" -ForegroundColor Yellow
Write-Host "  3. Review content in: " -NoNewline
Write-Host "layouts\index.html" -ForegroundColor Yellow
Write-Host "  4. Update social links with your actual URLs" -ForegroundColor Cyan
Write-Host ""
Write-Host "Backup saved at: $BackupFile" -ForegroundColor Cyan
Write-Host ""
Write-Host "Happy building! 🎮" -ForegroundColor Green
