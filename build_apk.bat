@echo off
title HIT BAKO - Android APK Builder
color 0b

echo ========================================================
echo        HIT BAKO - Android APK Build Assistant
echo ========================================================
echo.

:: 1. Check if Flutter is installed
where flutter >nul 2>nul
if %errorlevel% neq 0 (
    echo [!] Flutter SDK was not found on your system PATH.
    echo.
    echo To compile an APK on this computer, Flutter SDK and Android SDK are needed.
    echo.
    echo Would you like to install Flutter automatically using Windows Package Manager (winget)?
    echo [1] Yes, install Flutter via winget (requires internet)
    echo [2] No, I want to use Free Cloud Build (GitHub Actions - No download required)
    echo.
    set /p choice="Enter your choice (1 or 2): "
    if "%choice%"=="1" (
        echo.
        echo [*] Installing Flutter SDK via winget...
        winget install --id Google.Flutter -e --accept-package-agreements --accept-source-agreements
        echo.
        echo [OK] Please restart your terminal/IDE and run build_apk.bat again.
        pause
        exit /b
    ) else (
        echo.
        echo [*] Using Cloud Build:
        echo 1. Upload this project folder to your GitHub repository.
        echo 2. GitHub Actions will automatically compile and produce the APK in 2-3 minutes.
        echo 3. Download 'hit-bako-app-release.apk' from the Actions tab.
        pause
        exit /b
    )
)

echo [*] Flutter found! Checking dependencies...
call flutter pub get

echo.
echo [*] Building Release APK for HIT BAKO...
call flutter build apk --release

if %errorlevel% equ 0 (
    echo.
    echo ========================================================
    echo [SUCCESS] APK built successfully!
    echo Location: build\app\outputs\flutter-apk\app-release.apk
    echo ========================================================
    explorer.exe build\app\outputs\flutter-apk
) else (
    echo.
    echo [ERROR] Build failed. Please make sure Android Studio / Android SDK is configured with 'flutter doctor'.
)

pause
