@echo off
setlocal EnableExtensions

REM ============================================================
REM  Start Jupyter for the ChipWhisperer lab
REM
REM  Launches the virtual environment created by
REM  thonny_jupiter_and_packages_install.bat - NOT Thonny's own
REM  Python. Run the installer first (and after any --clean).
REM ============================================================

set "VENV_DIR=%LOCALAPPDATA%\cw_lab_venv"
set "PY=%VENV_DIR%\Scripts\python.exe"

if exist "%PY%" goto :VENV_OK

echo ERROR: Lab environment not found.
echo Expected: %PY%
echo.
echo Run thonny_jupiter_and_packages_install.bat first.
echo.
pause
exit /b 1

:VENV_OK

echo Using environment: %VENV_DIR%
"%PY%" --version
echo.

REM Run notebook from the folder this script lives in, so relative
REM paths in existing .ipynb files (data files, saved captures) keep
REM working regardless of where the .bat is double-clicked from.
cd /d "%~dp0"

echo Starting Jupyter Notebook...
echo Working directory: %CD%
echo.

"%PY%" -m notebook

endlocal