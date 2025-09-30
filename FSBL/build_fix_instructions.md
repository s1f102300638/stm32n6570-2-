/**
  ******************************************************************************
  * @file    build_fix_instructions.md
  * @brief   Instructions to fix build errors
  ******************************************************************************
  */

# ビルドエラー修正手順

## 1. ISP重複定義の修正

**問題**: `isp_services.c`と`isp_core.c`で`ISP_Init`と`ISP_Start`が重複定義されている

**解決方法**: 
STM32CubeIDEで`isp_services.c`をビルドから除外する

### 手順:
1. Project Explorerで`Middlewares/STM32_ISP/isp_services.c`を右クリック
2. "Resource Configurations" → "Exclude from Build..."を選択
3. "Debug"と"Release"両方にチェックを入れる
4. OKをクリック

## 2. RAMオーバーフロー（1.9MB超過）の修正

**問題**: YOLOモデルが大きすぎてRAMに収まらない

### 解決方法A: リンカースクリプトの修正

`STM32N657X0HXQ_AXISRAM2_fsbl.ld`を編集：

```ld
MEMORY
{
  /* 既存のメモリ領域 */
  RAM    (xrw)    : ORIGIN = 0x20000000, LENGTH = 768K
  
  /* AXISRAM2を拡張使用 */
  AXISRAM2 (xrw)  : ORIGIN = 0x24000000, LENGTH = 1536K
  
  /* 外部SDRAMがある場合追加 */
  /* SDRAM  (xrw)  : ORIGIN = 0xD0000000, LENGTH = 8192K */
}

/* セクション追加 */
SECTIONS
{
  /* ... 既存のセクション ... */
  
  /* AI用バッファセクション */
  .ai_buffers (NOLOAD) :
  {
    . = ALIGN(32);
    _ai_buffers_start = .;
    *(.ai_network_buffers)
    *(.ai_working_buffers)
    *(.yolo_deer_data)
    _ai_buffers_end = .;
  } > AXISRAM2
  
  /* BSS領域をAXISRAM2に移動 */
  .bss_axisram2 (NOLOAD) :
  {
    . = ALIGN(32);
    *yolo_deer.o(.bss)
    *yolo_deer.o(.bss*)
    *ai*.o(.bss)
    *ai*.o(.bss*)
  } > AXISRAM2
}
```

### 解決方法B: YOLOモデルの最適化

1. **X-CUBE-AIで再生成時の設定**:
   - "Optimization" → "Optimize for RAM"を選択
   - "Compression" → "8-bit quantization"を有効化
   - "Memory footprint" → "Minimize RAM"を選択

2. **より小さいモデルの使用**:
   - YOLO-tinyまたはMobileNetベースのモデルを検討

## 3. キャッシュ関数エラーの修正

**すでに対応済み**: `cache_operations.c`を作成済み

## 4. プロジェクト設定の最適化

### コンパイラ最適化:
1. Project → Properties → C/C++ Build → Settings
2. MCU GCC Compiler → Optimization
3. "Optimization Level"を"-Os"（サイズ最適化）に設定
4. "Link Time Optimization"を有効化

### 未使用コードの削除:
1. MCU GCC Linker → General
2. "Remove unused sections"にチェック
3. "Print removed sections"にチェック（デバッグ用）

## 5. ビルド手順

```bash
# 1. クリーンビルド
Project → Clean... → Clean all projects

# 2. インデックスの再構築
Project → C/C++ Index → Rebuild

# 3. ビルド
Project → Build All
```

## 6. それでもRAMが不足する場合

### 外部メモリの使用:

main.cに以下を追加：

```c
/* AI buffers in special section */
__attribute__((section(".ai_network_buffers")))
static uint8_t ai_network_buffer[1024 * 1024];  /* 1MB */

__attribute__((section(".ai_working_buffers")))
static uint8_t ai_working_buffer[512 * 1024];   /* 512KB */

/* In main() before AI init */
/* Enable external memory if available */
BSP_SDRAM_Init();  /* If SDRAM available */
```

## 7. デバッグ用メモリマップ確認

ビルド後、以下のファイルを確認：
- `Debug/mtk3bsp2_stm32n657_FSBL.map`

メモリ使用状況を確認：
```bash
arm-none-eabi-size mtk3bsp2_stm32n657_FSBL.elf
```

## 緊急対策

もし上記で解決しない場合：

1. **YOLOモデルを一時的に無効化**:
   - `app_x-cube-ai.c`でAI関連の呼び出しをコメントアウト
   - まず基本機能のビルドを確認

2. **段階的なメモリ削減**:
   - 不要なミドルウェアを無効化
   - デバッグ情報を削減（-g0）
   - printfなどのライブラリ機能を軽量版に置換

## 注意事項

- リンカースクリプトの変更後は必ずクリーンビルドを実行
- メモリマップファイル（.map）で実際の使用状況を確認
- STM32CubeMXでメモリ設定を変更した場合、手動修正が上書きされる可能性あり
