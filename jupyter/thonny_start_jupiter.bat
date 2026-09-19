```bat
@echo off
setlocal

echo ==========================================
echo Finding Thonny installation
echo ==========================================
echo.

REM ------------------------------------------------------------
REM Find Thonny installation
REM ------------------------------------------------------------

set "THONNY_EXE="

REM Check PATH first
for /f "delims=" %%I in ('where thonny.exe 2^>nul') do (
    set "THONNY_EXE=%%I"
    goto :THONNY_FOUND
)

REM Check standard per-user installation
if exist "%LOCALAPPDATA%\Programs\Thonny\thonny.exe" (
    set "THONNY_EXE=%LOCALAPPDATA%\Programs\Thonny\thonny.exe"
    goto :THONNY_FOUND
)

REM Check standard 64-bit installation
if exist "%ProgramFiles%\Thonny\thonny.exe" (
    set "THONNY_EXE=%ProgramFiles%\Thonny\thonny.exe"
    goto :THONNY_FOUND
)

REM Check standard 32-bit installation
if exist "%ProgramFiles(x86)%\Thonny\thonny.exe" (
    set "THONNY_EXE=%ProgramFiles(x86)%\Thonny\thonny.exe"
    goto :THONNY_FOUND
)

echo ERROR: Thonny was not found.
echo.
pause
exit /b 1


:THONNY_FOUND

REM ------------------------------------------------------------
REM Get Thonny installation directory
REM ------------------------------------------------------------

for %%I in ("%THONNY_EXE%") do set "THONNY_DIR=%%~dpI"

set "THONNY_PYTHON=%THONNY_DIR%python.exe"

echo Thonny found:
echo   %THONNY_EXE%
echo.
echo Python:
echo   %THONNY_PYTHON%
echo.

REM ------------------------------------------------------------
REM Verify Python exists
REM ------------------------------------------------------------

if not exist "%THONNY_PYTHON%" (
    echo ERROR: python.exe was not found in the Thonny installation.
    echo.
    echo Expected:
    echo %THONNY_PYTHON%
    echo.
    pause
    exit /b 1
)

REM ------------------------------------------------------------
REM Start Jupyter Notebook using Thonny's Python
REM ------------------------------------------------------------

echo Starting Jupyter Notebook...
echo.

"%THONNY_PYTHON%" -m notebook

endlocal
