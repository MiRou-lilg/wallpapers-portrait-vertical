@echo off
setlocal enabledelayedexpansion

echo ===============================================
echo   Connect Local Repository to Remote (main)
echo ===============================================
echo.

:: Prompt for the remote repository URL
set /p "remote_url=Paste your remote Git URL: "

:: Strip any accidental surrounding quotes
set "remote_url=!remote_url:"=!"

if "!remote_url!"=="" (
    echo.
    echo [ERROR] No URL provided. Operation canceled.
    pause
    exit /b
)

:: Step 1: Initialize Git if not already initialized
if not exist ".git" (
    echo.
    echo [1/3] Initializing local Git repository...
    git init
) else (
    echo.
    echo [1/3] Local Git repository detected.
)

:: Step 2: Set default branch name to main
echo [2/3] Setting default branch to 'main'...
git branch -M main

:: Step 3: Link remote origin
echo [3/3] Linking remote origin...
git remote add origin !remote_url! 2>nul
if %errorlevel% neq 0 (
    echo       'origin' already exists. Updating URL to new address...
    git remote set-url origin !remote_url!
)

echo.
echo ===============================================
echo   SUCCESSFULLY CONNECTED!
echo ===============================================
echo Current remote configuration:
git remote -v

echo.
echo You can now run your push script or run 'git push -u origin main'.
pause