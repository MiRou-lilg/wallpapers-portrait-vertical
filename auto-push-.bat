@echo off
setlocal enabledelayedexpansion

:: Ask for commit message
set /p "msg=Enter commit label: "

:: Use a default message if left empty
if "!msg!"=="" set "msg=Automated wallpaper update"

echo.
echo ===================================
echo   Staging files...
echo ===================================
git add .

echo.
echo ===================================
echo   Committing changes...
echo ===================================
git commit -m "!msg!"

echo.
echo ===================================
echo   Pushing to GitHub...
echo ===================================

:: Check if the current branch already has an upstream set
git rev-parse --abbrev-ref --symbolic-full-name @{u} >nul 2>&1
if %errorlevel% neq 0 (
    echo No upstream branch found - setting it now...
    for /f "tokens=*" %%b in ('git rev-parse --abbrev-ref HEAD') do set "branch=%%b"
    git push --set-upstream origin !branch!
) else (
    git push
)

echo.
echo ===================================
echo   Done!
echo ===================================
pause
