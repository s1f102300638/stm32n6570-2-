@echo off
REM Windows batch file for quick fix application
REM Run this in STM32CubeIDE Console or Windows CMD

echo ==========================================
echo STM32N657 FSBL Quick Fix Script
echo ==========================================
echo.

echo Step 1: Backing up original linker script
copy STM32N657X0HXQ_AXISRAM2_fsbl.ld STM32N657X0HXQ_AXISRAM2_fsbl.ld.backup

echo.
echo Step 2: ISP重複を修正するため、isp_services.cを一時的にリネーム
if exist "Middlewares\STM32_ISP\isp_services.c" (
    ren "Middlewares\STM32_ISP\isp_services.c" "isp_services.c.disabled"
    echo isp_services.c を無効化しました
) else (
    echo isp_services.c が見つかりません - すでに無効化されている可能性があります
)

echo.
echo ==========================================
echo 次の手動作業が必要です：
echo ==========================================
echo.
echo 1. STM32CubeIDE内で:
echo    - プロジェクトを右クリック
echo    - Properties を選択
echo    - C/C++ Build → Settings
echo    - MCU GCC Linker → General
echo    - Linker Script を以下に変更:
echo      STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld
echo.
echo 2. もしまだエラーが出る場合:
echo    app_x-cube-ai.c ファイルを開いて、以下の行をコメントアウト:
echo    // MX_X_CUBE_AI_Init();
echo    // MX_X_CUBE_AI_Process();
echo.
echo 3. Project → Clean... → Clean all projects
echo 4. Project → Build Project
echo.
pause
