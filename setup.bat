@echo off
REM ===== Portfolio CV Setup Script (Windows) =====
REM For Windows Command Prompt (CMD)
REM This script interactively configures your portfolio

setlocal enabledelayedexpansion

REM Set colors using escape codes (Windows 10+)
cls
echo.
echo  __________________________________________________________
echo ^|                                                          ^|
echo ^|    Portfolio CV Setup Script - Windows Edition          ^|
echo ^|    Press Enter to skip any field                         ^|
echo ^|__________________________________________________________^|
echo.

REM Get script directory
set SCRIPT_DIR=%~dp0
set LAYOUT_FILE=%SCRIPT_DIR%layouts\index.html
set BACKUP_FILE=%SCRIPT_DIR%layouts\index.html.backup.%RANDOM%

REM Backup original file
echo Backing up original file...
copy "%LAYOUT_FILE%" "%BACKUP_FILE%" >nul
echo Backup created: %BACKUP_FILE%
echo.

REM Initialize variables
set FULL_NAME=YOUR NAME HERE
set EMAIL=your@email.com
set DOMAIN=yourdomain.com
set GITHUB_USER=yourprofile
set TWITTER_HANDLE=yourhandle
set LINKEDIN_PROFILE=yourprofile

echo ======================================================
echo PERSONAL INFORMATION
echo ======================================================

:prompt_name
set /p FULL_NAME="Enter your full name [YOUR NAME HERE]: "
if "!FULL_NAME!"=="" set FULL_NAME=YOUR NAME HERE
if "!FULL_NAME!"==" " goto prompt_name
echo.

:prompt_email
set /p EMAIL="Enter your email [your@email.com]: "
if "!EMAIL!"=="" set EMAIL=your@email.com
REM Simple email validation
echo !EMAIL! | findstr /R "^[a-zA-Z0-9._%+-]*@[a-zA-Z0-9.-]*\.[a-zA-Z]{2,}$" >nul
if errorlevel 1 (
    if not "!EMAIL!"=="your@email.com" (
        echo Invalid email format. Please try again.
        goto prompt_email
    )
)
echo.

:prompt_domain
set /p DOMAIN="Enter your domain [yourdomain.com]: "
if "!DOMAIN!"=="" set DOMAIN=yourdomain.com
echo.

echo ======================================================
echo SOCIAL MEDIA PROFILES (Optional)
echo ======================================================

set /p GITHUB_USER="GitHub username [yourprofile]: "
if "!GITHUB_USER!"=="" set GITHUB_USER=yourprofile
echo.

set /p TWITTER_HANDLE="Twitter/X handle [yourhandle]: "
if "!TWITTER_HANDLE!"=="" set TWITTER_HANDLE=yourhandle
echo.

set /p LINKEDIN_PROFILE="LinkedIn profile [yourprofile]: "
if "!LINKEDIN_PROFILE!"=="" set LINKEDIN_PROFILE=yourprofile
echo.

echo ======================================================
echo SUMMARY OF CHANGES
echo ======================================================
echo.
echo Name:              !FULL_NAME!
echo Email:             !EMAIL!
echo Domain:            !DOMAIN!
echo GitHub:            !GITHUB_USER!
echo Twitter:           !TWITTER_HANDLE!
echo LinkedIn:          !LINKEDIN_PROFILE!
echo.

set /p CONFIRM="Proceed with updates? (y/n): "
if /i not "!CONFIRM!"=="y" (
    echo.
    echo Setup cancelled. Cleaning up backup...
    del "!BACKUP_FILE!"
    exit /b 1
)

echo.
echo Updating files...

REM PowerShell is available on Windows 10+ and handles string replacement better
powershell -Command "& {
    $file = '%LAYOUT_FILE%'
    $content = Get-Content $file -Raw
    
    $content = $content -replace 'YOUR NAME HERE', '!FULL_NAME!'
    $content = $content -replace 'your@email.com', '!EMAIL!'
    $content = $content -replace 'yourdomain\.com', '!DOMAIN!'
    $content = $content -replace 'yourprofile', '!GITHUB_USER!'
    $content = $content -replace 'yourhandle', '!TWITTER_HANDLE!'
    $content = $content -replace 'Portfolio Owner', '!FULL_NAME!'
    
    Set-Content $file $content -Encoding UTF8
    Write-Host 'File updated successfully'
}"

if errorlevel 1 (
    echo.
    echo Error: PowerShell replacement failed. Restoring backup...
    copy "!BACKUP_FILE!" "!LAYOUT_FILE!" >nul
    exit /b 1
)

REM Rebuild Hugo
echo.
echo Rebuilding Hugo site...
where hugo >nul 2>&1
if errorlevel 1 (
    echo.
    echo WARNING: Hugo not found in PATH
    echo Install Hugo from: https://gohugo.io/installation/
) else (
    cd /d "%SCRIPT_DIR%"
    call hugo >nul
    echo Build complete
)

echo.
echo ======================================================
echo    SETUP COMPLETE!
echo ======================================================
echo.
echo Next steps:
echo   1. Start dev server:  hugo server
echo   2. Visit:            http://localhost:1313
echo   3. Review content in: layouts\index.html
echo   4. Update all social links with your actual URLs
echo.
echo Backup saved at: !BACKUP_FILE!
echo.
pause
