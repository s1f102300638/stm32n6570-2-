@echo off
REM ******************************************************************************
REM Quick Build Fix for STM32N6 YOLO Project
REM This script applies the necessary fixes to build the project
REM ******************************************************************************

echo ===================================================
echo STM32N6 YOLO Project - Quick Build Fix
echo ===================================================
echo.

REM Check if we're in the FSBL directory
if not exist "STM32N657X0HXQ_AXISRAM2_fsbl.ld" (
    echo ERROR: Please run this script from the FSBL directory!
    pause
    exit /b 1
)

echo Step 1: Renaming problematic files...
echo --------------------------------------

REM Rename the original yolo_deer.c to prevent it from being compiled
if exist "X-CUBE-AI\App\yolo_deer.c" (
    if not exist "X-CUBE-AI\App\yolo_deer.c.backup" (
        ren "X-CUBE-AI\App\yolo_deer.c" "yolo_deer.c.backup"
        echo - Renamed yolo_deer.c to yolo_deer.c.backup
    ) else (
        echo - yolo_deer.c already backed up
    )
)

echo.
echo Step 2: Using optimized linker script...
echo --------------------------------------

REM Check if optimized linker script exists
if exist "STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld" (
    echo - Optimized linker script found
    
    REM Update .cproject to use optimized linker script
    if exist ".cproject" (
        powershell -Command "(Get-Content '.cproject') -replace 'STM32N657X0HXQ_AXISRAM2_fsbl\.ld', 'STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld' | Set-Content '.cproject'"
        echo - Updated .cproject to use optimized linker script
    )
) else (
    echo ! WARNING: Optimized linker script not found!
    echo   Using default linker script
)

echo.
echo Step 3: Cleaning build directories...
echo --------------------------------------

REM Clean Debug directory
if exist "Debug" (
    rmdir /S /Q "Debug" 2>nul
    mkdir "Debug"
    echo - Cleaned Debug directory
)

REM Clean Release directory  
if exist "Release" (
    rmdir /S /Q "Release" 2>nul
    mkdir "Release"
    echo - Cleaned Release directory
)

echo.
echo ===================================================
echo Quick fix applied successfully!
echo ===================================================
echo.
echo Next steps:
echo 1. Open STM32CubeIDE
echo 2. Refresh the project (F5)
echo 3. Project menu - Clean...
echo 4. Project menu - Build All
echo.
echo If build still fails:
echo - Check Console view for specific errors
echo - Ensure all X-CUBE-AI files are present
echo - Try: Project - Properties - C/C++ Build - Refresh Policy
echo.
pause
