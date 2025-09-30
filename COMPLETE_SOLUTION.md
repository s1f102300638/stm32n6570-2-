# STM32N6 YOLO Project - 完全修正ガイド

## 🎯 プロジェクト構成の理解

### STM32N6のメモリアーキテクチャ
- **内部フラッシュなし**: 全てのコードは外部メモリに保存
- **FSBL必須**: First Stage Boot Loaderが起動を管理
- **AI重み**: 外部フラッシュ（XSPI2）に配置

## 📁 プロジェクト構造

```
mtk3bsp2_stm32n657/
├── FSBL/           # First Stage Boot Loader (必須)
│   ├── Core/       # HAL初期化
│   ├── X-CUBE-AI/  # AI推論エンジン（問題箇所）
│   └── *.ld        # リンカスクリプト
│
├── Appli/          # メインアプリケーション
│   ├── Application/# アプリケーションロジック
│   ├── Core/       # システム設定
│   └── *.ld        # 実行モード別リンカスクリプト
│
└── Middlewares/    # 共通ライブラリ
    └── ST/AI/      # Neural-ART NPU サポート

```

## 🚨 根本的な問題

### 1. FSBL単独では不完全
- FSBLは「ブートローダー」であり、アプリケーション本体ではない
- AI推論はAppliで実行すべき

### 2. X-CUBE-AIの配置ミス
- 巨大な重みデータ（11.5MB）がFSBLに含まれている
- FSBLは511KB制限がある（内部SRAM実行のため）

### 3. ブートモードの誤解
- DEV MODE: デバッグ用（電源オフでコード消失）
- FLASH MODE: 製品用（外部フラッシュから起動）

## ✅ 正しい実装方法

### Phase 1: FSBL最小化
```c
// FSBL/main.c - 最小限の実装
void main(void) {
    // 1. クロック設定
    SystemClock_Config();
    
    // 2. 外部メモリ初期化
    MX_XSPI1_Init();  // HyperRAM
    MX_XSPI2_Init();  // OctoFlash
    
    // 3. NPU初期化
    __HAL_RCC_NPU_CLK_ENABLE();
    
    // 4. Appliへジャンプ
    JumpToApplication(APPLI_ADDRESS);
}
```

### Phase 2: Appli側でAI実装
```c
// Appli/Application/app_main.c
#include "ai_platform.h"
#include "yolo_deer.h"

void AI_Init(void) {
    // AI重みは外部フラッシュから読み込み
    ai_handle network = ai_yolo_deer_create_external(
        XSPI2_BASE + AI_WEIGHTS_OFFSET
    );
}

void AI_Process(void) {
    // カメラ画像取得
    camera_capture(input_buffer);
    
    // NPUで推論実行
    ai_yolo_deer_run(network, input_buffer, output_buffer);
    
    // 結果処理
    process_detection_results(output_buffer);
}
```

## 🛠️ 段階的修正手順

### Step 1: プロジェクトの再構成
```bash
# 1. FSBLをクリーンアップ
cd FSBL
rm -rf X-CUBE-AI/App/yolo_deer.c
# AI関連コードを全て削除

# 2. Appliに AI実装を移動
cd ../Appli
mkdir -p Application/AI
# AI関連ファイルをここに配置
```

### Step 2: リンカスクリプトの選択

#### FSBL用:
```ld
/* STM32N657X0HXQ_AXISRAM2_fsbl.ld */
MEMORY {
  ROM (xrw)    : ORIGIN = 0x34180400, LENGTH = 255K  /* FSBLコード */
  RAM (xrw)    : ORIGIN = 0x341C0000, LENGTH = 256K  /* スタック/変数 */
}
```

#### Appli用（LRUN - Load & Run）:
```ld
/* STM32N657X0HXQ_LRUN.ld */
MEMORY {
  RAM    (xrw) : ORIGIN = 0x34000000, LENGTH = 4M    /* 全内部RAM使用 */
  XSPI2  (rx)  : ORIGIN = 0x71000000, LENGTH = 128M  /* AI重み配置 */
}
```

### Step 3: バイナリの生成と署名

```bash
# 1. FSBL ビルド
cd FSBL
make clean && make

# 2. FSBL署名
STM32_SigningTool_CLI.exe -bin FSBL.bin -nk -of 0x80000000 \
    -t fsbl -o FSBL-trusted.bin -hv 2.3

# 3. Appli ビルド  
cd ../Appli
make clean && make

# 4. Appli署名
STM32_SigningTool_CLI.exe -bin Appli.bin -nk -of 0x80000000 \
    -t fsbl -o Appli-trusted.bin -hv 2.3
```

### Step 4: フラッシュへの書き込み

```bash
# 外部ローダーを設定
EXTLOADER="MX66UW1G45G_STM32N6570-DK.stldr"

# 1. FSBLを 0x70000000 に書き込み
STM32_Programmer_CLI -c port=SWD mode=HOTPLUG -el $EXTLOADER \
    -w FSBL-trusted.bin 0x70000000

# 2. Appliを 0x70100000 に書き込み  
STM32_Programmer_CLI -c port=SWD mode=HOTPLUG -el $EXTLOADER \
    -w Appli-trusted.bin 0x70100000

# 3. AI重みを 0x71000000 に書き込み
STM32_Programmer_CLI -c port=SWD mode=HOTPLUG -el $EXTLOADER \
    -w yolo_weights.bin 0x71000000
```

## 📊 メモリマップ（正しい配置）

```
外部フラッシュ (OctoFlash):
├── 0x70000000: FSBL (署名付き, ~256KB)
├── 0x70100000: Appli (署名付き, ~2MB)
└── 0x71000000: AI Weights (11.5MB)

内部RAM (実行時):
├── 0x34180400: FSBL実行領域 (255KB)
├── 0x34000000: Appli実行領域 (4MB)
└── 0x34200000: NPU作業領域 (1.8MB)
```

## ⚙️ STM32CubeMXでの設定

### 1. プロジェクトタイプ選択
- **FSBL LRUN**: Appliを内部RAMで実行（推奨）
- **FSBL XIP**: Appliを外部フラッシュから直接実行

### 2. X-CUBE-AI設定
- **Network Type**: Neural-ART Accelerator
- **Weights Storage**: External Flash
- **Runtime**: Optimized for NPU

### 3. Boot Configuration
```
BOOT1 = LOW  : Flash Boot Mode（製品用）
BOOT1 = HIGH : DEV Mode（開発用）
```

## 🎯 推奨アプローチ

### 開発フェーズ:
1. **DEVモード**でデバッグ
2. FSBLは最小限の実装
3. Appliで全機能を実装・テスト

### 本番フェーズ:
1. FSBLとAppliを分離
2. 両方を署名
3. 外部フラッシュに書き込み
4. Flashブートモードで起動

## 📝 チェックリスト

- [ ] FSBLは511KB以下
- [ ] AI重みは外部フラッシュに配置
- [ ] バイナリは署名済み
- [ ] ブートモードは正しく設定
- [ ] 外部メモリローダーは有効
- [ ] NPUクロックは有効

## 🔗 参考資料

1. [STM32N6 FSBL explained](https://community.st.com/t5/stm32-mcus/stm32n6-fsbl-explained/ta-p/764307)
2. [How to create an STM32N6 FSBL load and run](https://community.st.com/t5/stm32-mcus/how-to-create-an-stm32n6-fsbl-load-and-run/ta-p/768206)
3. [UM3234: Boot ROM on STM32N6 MCUs](https://www.st.com/resource/en/user_manual/um3234)
4. [X-CUBE-AI Documentation](https://wiki.st.com/stm32mcu/wiki/AI:X-CUBE-AI_documentation)

---
**重要**: FSBLだけでは解決しません。Appliとの適切な分離と、外部メモリの正しい活用が必要です。
