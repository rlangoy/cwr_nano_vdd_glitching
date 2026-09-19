@echo off
setlocal EnableExtensions

REM ============================================================
REM  ChipWhisperer lab: Jupyter environment installer
REM
REM  Creates an isolated virtual environment from Thonny's Python
REM  and installs a pinned, tested package set from
REM  requirements-lab.txt (same folder as this script).
REM
REM  Usage:
REM    thonny_jupiter_and_packages_install.bat           install or update
REM    thonny_jupiter_and_packages_install.bat --clean   rebuild from scratch
REM
REM  Close any running Jupyter server first: Windows locks loaded
REM  .pyd files, so upgrading packages in use will fail.
REM ============================================================

set "VENV_DIR=%LOCALAPPDATA%\cw_lab_venv"
set "REQ_FILE=%~dp0requirements-lab.txt"
set "CW_VERSION=6.0.0"
set "PIP_OPTS=--disable-pip-version-check --no-warn-script-location"
set "PIPCHECK_LOG=%TEMP%\cw_lab_pipcheck.txt"

echo ==========================================
echo Finding Thonny installation
echo ==========================================
echo.

set "THONNY_EXE="

REM Check PATH first
for /f "delims=" %%I in ('where thonny.exe 2^>nul') do (
    set "THONNY_EXE=%%I"
    goto :THONNY_FOUND
)

REM Standard per-user installation
if exist "%LOCALAPPDATA%\Programs\Thonny\thonny.exe" (
    set "THONNY_EXE=%LOCALAPPDATA%\Programs\Thonny\thonny.exe"
    goto :THONNY_FOUND
)

REM Standard 64-bit installation
if exist "%ProgramFiles%\Thonny\thonny.exe" (
    set "THONNY_EXE=%ProgramFiles%\Thonny\thonny.exe"
    goto :THONNY_FOUND
)

REM Standard 32-bit installation
if exist "%ProgramFiles(x86)%\Thonny\thonny.exe" (
    set "THONNY_EXE=%ProgramFiles(x86)%\Thonny\thonny.exe"
    goto :THONNY_FOUND
)

echo ERROR: Thonny was not found.
echo.
pause
exit /b 1


:THONNY_FOUND

for %%I in ("%THONNY_EXE%") do set "THONNY_DIR=%%~dpI"
set "THONNY_PYTHON=%THONNY_DIR%python.exe"

REM Paths are echoed outside parenthesised blocks on purpose: a path
REM containing a closing parenthesis, e.g. Program Files x86, would
REM otherwise terminate the block early.
if exist "%THONNY_PYTHON%" goto :PYTHON_OK
echo ERROR: python.exe was not found in the Thonny installation.
echo Expected: %THONNY_PYTHON%
echo.
pause
exit /b 1

:PYTHON_OK
echo Thonny: %THONNY_EXE%
echo Python: %THONNY_PYTHON%
"%THONNY_PYTHON%" --version
echo.

if exist "%REQ_FILE%" goto :REQ_OK
echo ERROR: Requirements file not found.
echo Expected: %REQ_FILE%
echo.
pause
exit /b 1

:REQ_OK


REM ------------------------------------------------------------
REM Virtual environment
REM Kept in LOCALAPPDATA, not in the lab folder: Documents is often
REM synced by OneDrive, which does not cope well with a venv.
REM ------------------------------------------------------------

echo ==========================================
echo Virtual environment
echo ==========================================
echo Location: %VENV_DIR%
echo.

if /i "%~1"=="--clean" if exist "%VENV_DIR%" (
    echo Removing existing environment...
    rmdir /s /q "%VENV_DIR%"
)

if exist "%VENV_DIR%\Scripts\python.exe" goto :VENV_EXISTS
echo Creating virtual environment...
"%THONNY_PYTHON%" -m venv "%VENV_DIR%"
if errorlevel 1 goto :INSTALL_ERROR

:VENV_EXISTS
set "PY=%VENV_DIR%\Scripts\python.exe"

"%PY%" -c "import sys" >nul 2>&1
if errorlevel 1 (
    echo ERROR: The existing environment does not start - was Thonny updated?
    goto :INSTALL_ERROR
)
echo.


REM ------------------------------------------------------------
REM pip
REM ------------------------------------------------------------

echo ==========================================
echo Upgrading pip
echo ==========================================
echo.

"%PY%" -m pip install %PIP_OPTS% --upgrade pip
if errorlevel 1 goto :INSTALL_ERROR


REM ------------------------------------------------------------
REM All lab packages in ONE resolver run, so pip sees every
REM constraint at once instead of undoing earlier steps.
REM --only-binary: never compile these from source. Student laptops
REM normally have no C compiler, so a missing wheel should fail fast
REM with a clear message instead of attempting a long MSVC build.
REM ------------------------------------------------------------

echo.
echo ==========================================
echo Installing lab packages
echo ==========================================
echo.

"%PY%" -m pip install %PIP_OPTS% --only-binary=numpy,pandas,matplotlib -r "%REQ_FILE%"
if errorlevel 1 goto :INSTALL_ERROR


REM ------------------------------------------------------------
REM ChipWhisperer 6.0.0 declares numpy 1.26.4 or older. That numpy
REM has no wheels for Python 3.13 and newer, and pandas 3 (pulled in
REM by holoviews) needs numpy 2.3.3 or newer on Python 3.14.
REM Its other dependencies are listed in requirements-lab.txt, so the
REM package itself is installed with --no-deps.
REM ------------------------------------------------------------

echo.
echo ==========================================
echo Installing ChipWhisperer %CW_VERSION% without its numpy pin
echo ==========================================
echo.

"%PY%" -m pip install %PIP_OPTS% --no-deps chipwhisperer==%CW_VERSION%
if errorlevel 1 goto :INSTALL_ERROR


REM ------------------------------------------------------------
REM Import test: proves the packages actually load together
REM ------------------------------------------------------------

echo.
echo ==========================================
echo Import test
echo ==========================================
echo.

"%PY%" -c "import sys, importlib.metadata as md; import numpy, pandas, matplotlib, ipympl, ipywidgets, holoviews, chipwhisperer; print('Python: ' + sys.executable); [print('  ' + p.ljust(15) + md.version(p)) for p in ('numpy', 'pandas', 'matplotlib', 'ipympl', 'ipywidgets', 'holoviews', 'bokeh', 'notebook', 'jupyterlab', 'chipwhisperer')]"
if errorlevel 1 goto :INSTALL_ERROR


REM ------------------------------------------------------------
REM Dependency check. pip install exits with code 0 even when it
REM prints dependency conflicts, so check explicitly. The only
REM accepted conflict is the chipwhisperer numpy pin.
REM ------------------------------------------------------------

echo.
echo ==========================================
echo Dependency check
echo ==========================================
echo.

"%PY%" -m pip check > "%PIPCHECK_LOG%" 2>&1
type "%PIPCHECK_LOG%"

findstr /v /c:"has requirement numpy<=1.26.4" /c:"No broken requirements" "%PIPCHECK_LOG%" >nul
if errorlevel 1 goto :CHECK_OK

echo.
echo ERROR: Unexpected dependency conflicts, see the list above.
goto :INSTALL_ERROR

:CHECK_OK
echo OK - only the known chipwhisperer numpy pin is reported.


echo.
echo ==========================================
echo Installation completed successfully
echo ==========================================
echo.
echo Start Jupyter with thonny_start_jupiter.bat
echo It must use this interpreter: %PY%
echo.

pause
exit /b 0


:INSTALL_ERROR

echo.
echo ==========================================
echo ERROR: Installation failed
echo ==========================================
echo.
echo Check the messages above.
echo If the environment seems broken, run this script again with --clean
echo.

pause
exit /b 1