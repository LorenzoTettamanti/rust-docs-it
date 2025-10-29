@echo off
REM Setup script for rust-docs-it development environment (Windows)
REM Run from project root: dev-setup\setup-dev.bat

echo 🦀 Setting up Rust Docs IT development environment...

REM Ensure we're in the project root
if not exist "mkdocs.yml" (
    echo ❌ Error: Please run this script from the project root directory
    echo    Usage: dev-setup\setup-dev.bat
    exit /b 1
)

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python 3 is required but not installed.
    exit /b 1
)

REM Create virtual environment if it doesn't exist
if not exist "venv" (
    echo 📦 Creating Python virtual environment...
    python -m venv venv
)

REM Activate virtual environment
echo 🔌 Activating virtual environment...
call venv\Scripts\activate.bat

REM Install Python dependencies
echo 📚 Installing Python dependencies...
python -m pip install --upgrade pip
pip install -r requirements.txt

REM Install pre-commit hooks
echo 🪝 Installing pre-commit hooks...
pip install pre-commit
pre-commit install

REM Install markdownlint (requires npm/node)
where npm >nul 2>&1
if %errorlevel% == 0 (
    echo 📝 Installing markdownlint-cli...
    npm install -g markdownlint-cli
) else (
    echo ⚠️  npm not found. Skipping markdownlint-cli installation.
    echo    Install Node.js to enable markdown linting.
)

echo.
echo ✅ Development environment setup complete!
echo.
echo Next steps:
echo   1. Activate the environment: venv\Scripts\activate.bat
echo   2. Start the dev server: mkdocs serve
echo   3. Open http://127.0.0.1:8000 in your browser
echo.
echo Pre-commit hooks are now active! They will run automatically on 'git commit'.
echo To manually run all hooks: pre-commit run --all-files
echo.

pause
