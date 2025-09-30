@echo off
REM ******************************************************************************
REM Apply Build Fix Script for STM32N6 YOLO Project (Windows version)
REM This script modifies the build configuration to fix RAM overflow issues
REM ******************************************************************************

echo ===================================================
echo STM32N6 YOLO Project Build Fix Script (Windows)
echo ===================================================
echo.

REM Check if we're in the FSBL directory
if not exist "STM32N657X0HXQ_AXISRAM2_fsbl.ld" (
    echo ERROR: Please run this script from the FSBL directory!
    pause
    exit /b 1
)

echo Step 1: Backing up original files...
echo --------------------------------------

REM Create backup directory
if not exist "build_backup" mkdir build_backup

REM Backup original files
if exist ".cproject" (
    copy /Y ".cproject" "build_backup\cproject.original" >nul
    echo - Backed up .cproject
)

if exist "makefile" (
    copy /Y "makefile" "build_backup\makefile.original" >nul
    echo - Backed up makefile
)

if exist "Makefile" (
    copy /Y "Makefile" "build_backup\Makefile.original" >nul
    echo - Backed up Makefile
)

echo.
echo Step 2: Creating modified Makefile...
echo --------------------------------------

REM Read the original Makefile and create a modified version
if exist "Makefile" (
    powershell -Command "(Get-Content 'Makefile') -replace 'STM32N657X0HXQ_AXISRAM2_fsbl\.ld', 'STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld' -replace 'yolo_deer\.c', 'yolo_deer_stub.c' | Set-Content 'Makefile.new'"
    if exist "Makefile.new" (
        move /Y "Makefile.new" "Makefile" >nul
        echo - Updated Makefile
    )
)

if exist "makefile" (
    powershell -Command "(Get-Content 'makefile') -replace 'STM32N657X0HXQ_AXISRAM2_fsbl\.ld', 'STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld' -replace 'yolo_deer\.c', 'yolo_deer_stub.c' | Set-Content 'makefile.new'"
    if exist "makefile.new" (
        move /Y "makefile.new" "makefile" >nul
        echo - Updated makefile
    )
)

echo.
echo Step 3: Updating project configuration...
echo --------------------------------------

REM Update .cproject file
if exist ".cproject" (
    powershell -Command "(Get-Content '.cproject') -replace 'STM32N657X0HXQ_AXISRAM2_fsbl\.ld', 'STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld' | Set-Content '.cproject.new'"
    if exist ".cproject.new" (
        move /Y ".cproject.new" ".cproject" >nul
        echo - Updated .cproject
    )
)

echo.
echo Step 4: Checking required files...
echo --------------------------------------

REM Check if stub file exists
if exist "X-CUBE-AI\App\yolo_deer_stub.c" (
    echo - yolo_deer_stub.c exists
) else (
    echo ! WARNING: yolo_deer_stub.c not found!
    echo   Please ensure the stub file has been created
)

REM Check if optimized linker script exists
if exist "STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld" (
    echo - Optimized linker script exists
) else (
    echo ! WARNING: STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld not found!
    echo   Please ensure the optimized linker script has been created
)

echo.
echo Step 5: Cleaning build artifacts...
echo --------------------------------------

REM Clean Debug directory
if exist "Debug" (
    del /Q /S "Debug\*.*" >nul 2>&1
    echo - Cleaned Debug directory
)

REM Clean Release directory
if exist "Release" (
    del /Q /S "Release\*.*" >nul 2>&1
    echo - Cleaned Release directory
)

echo.
echo ===================================================
echo Build fix has been applied!
echo ===================================================
echo.
echo Next steps:
echo 1. Open the project in STM32CubeIDE
echo 2. Right-click on project - Clean Project
echo 3. Right-click on project - Build Project
echo.
echo If you still encounter issues:
echo 1. Check that all modified files are saved
echo 2. Refresh the project (F5)
echo 3. Check the Console view for detailed error messages
echo.
echo To restore original files:
echo   copy build_backup\*.* .
echo.
echo ===================================================
pause
