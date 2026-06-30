@echo off
REM ═════════════════════════════════════════════════════════════
REM CineHub Backend — Development Startup Script (Windows)
REM ═════════════════════════════════════════════════════════════

setlocal enabledelayedexpansion

echo.
echo ╔═════════════════════════════════════════════╗
echo ║  🎬 CineHub Backend — Startup Script        ║
echo ╚═════════════════════════════════════════════╝
echo.

REM Check Node.js
node --version >nul 2>&1
if errorlevel 1 (
  echo ❌ Node.js not found
  echo    Install from: https://nodejs.org/
  pause
  exit /b 1
)
for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
echo ✓ Node.js !NODE_VERSION!

REM Check npm
npm --version >nul 2>&1
if errorlevel 1 (
  echo ❌ npm not found
  pause
  exit /b 1
)
for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
echo ✓ npm !NPM_VERSION!

REM Check if in server directory
if not exist "package.json" (
  echo ❌ package.json not found
  echo    Please run this from the 'server' directory
  pause
  exit /b 1
)

echo.

REM Check .env file
if not exist ".env" (
  echo ⚠️  .env file not found
  
  if exist ".env.example" (
    echo    Creating .env from .env.example...
    copy .env.example .env >nul
    echo ✓ .env created
    echo    ⚠️  Please update .env with your actual configuration
    echo    Then run this script again
    pause
    exit /b 0
  ) else (
    echo ❌ .env.example not found
    pause
    exit /b 1
  )
)

echo ✓ .env file exists
echo.

REM Install dependencies
echo 📦 Installing dependencies...
call npm install
if errorlevel 1 (
  echo ❌ Failed to install dependencies
  pause
  exit /b 1
)
echo ✓ Dependencies installed
echo.

REM Start server
echo 🚀 Starting development server...
echo.

call npm run dev
if errorlevel 1 (
  echo ❌ Server failed to start
  pause
  exit /b 1
)

pause
