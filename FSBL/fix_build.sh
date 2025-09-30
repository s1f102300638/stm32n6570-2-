#!/bin/bash
# STM32N657 FSBL Build Fix Script
# Execute these steps in STM32CubeIDE

echo "=========================================="
echo "STM32N657 FSBL ビルドエラー修正手順"
echo "=========================================="

echo ""
echo "Step 1: ISP重複定義の修正"
echo "----------------------------------------"
echo "1. Project Explorer で以下のファイルを右クリック:"
echo "   Middlewares/STM32_ISP/isp_services.c"
echo "2. 'Resource Configurations' → 'Exclude from Build...' を選択"
echo "3. 'Debug' と 'Release' の両方にチェック"
echo "4. OK をクリック"

echo ""
echo "Step 2: リンカースクリプトの変更"
echo "----------------------------------------"
echo "1. プロジェクトのプロパティを開く (右クリック → Properties)"
echo "2. C/C++ Build → Settings → MCU GCC Linker → General"
echo "3. Linker Script: STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld に変更"
echo "4. Apply"

echo ""
echo "Step 3: コンパイラ最適化"
echo "----------------------------------------"
echo "1. MCU GCC Compiler → Optimization"
echo "2. Optimization Level: -Os (Optimize for size)"
echo "3. Link-time optimization: チェック"
echo "4. Apply and Close"

echo ""
echo "Step 4: プリプロセッサマクロの追加"
echo "----------------------------------------"
echo "1. MCU GCC Compiler → Preprocessor"
echo "2. Define symbols に追加:"
echo "   DATA_CACHE_ENABLE=0"
echo "   INSTRUCTION_CACHE_ENABLE=0"
echo "3. Apply"

echo ""
echo "Step 5: ビルド実行"
echo "----------------------------------------"
echo "1. Project → Clean..."
echo "2. Clean all projects を選択"
echo "3. Clean 実行"
echo "4. Project → Build All"

echo ""
echo "=========================================="
echo "追加の対処が必要な場合"
echo "=========================================="

echo ""
echo "Option A: YOLOモデルの無効化 (一時的)"
echo "----------------------------------------"
cat << 'EOF'
app_x-cube-ai.c の以下の行をコメントアウト:
  // MX_X_CUBE_AI_Init();
  // MX_X_CUBE_AI_Process();
EOF

echo ""
echo "Option B: メモリマップの確認"
echo "----------------------------------------"
echo "ビルド後、以下のコマンドで確認:"
echo "arm-none-eabi-size Debug/mtk3bsp2_stm32n657_FSBL.elf"
echo ""
echo "メモリマップファイルを確認:"
echo "Debug/mtk3bsp2_stm32n657_FSBL.map"

echo ""
echo "=========================================="
echo "それでも解決しない場合"
echo "=========================================="
echo "1. STM32CubeMX でプロジェクトを再生成"
echo "2. X-CUBE-AI で小さいモデルを選択"
echo "3. YOLO-tiny や MobileNet への変更を検討"
