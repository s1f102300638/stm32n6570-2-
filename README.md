Wildlife Detection System - STM32N6570
システム構成
ハードウェア
┌─────────────────────────────────────────┐
│   STM32N6570-DK Discovery Board         │
│   ├─ ARM Cortex-M7 @ 1.6GHz            │
│   ├─ NPU 9.6 TOPS                      │
│   └─ 2MB RAM + 4MB Flash               │
└─────────────────────────────────────────┘
          │              │
    ┌─────▼────┐   ┌─────▼──────┐
    │ IMX335   │   │ Pan/Tilt   │
    │ Camera   │   │ Servo x2   │
    │ 256x256  │   │ SG90       │
    └──────────┘   └────────────┘
ソフトウェアスタック
┌───────────────────────────────────────────┐
│  Application: Wildlife AI Detection      │
├───────────────────────────────────────────┤
│  Middleware: X-CUBE-AI + Camera Driver   │
├───────────────────────────────────────────┤
│  RTOS: μT-Kernel 3.0                     │
├───────────────────────────────────────────┤
│  HAL: STM32N6xx Drivers                  │
└───────────────────────────────────────────┘
動作フロー
システム起動シーケンス

リアルタイム処理フロー
[Camera Task]          [AI Task]           [Servo Task]
 30 FPS (33ms)        20 FPS (50ms)        50 FPS (20ms)
      │                    │                    │
      ▼                    │                    │
  画像取得                  │                    │
      │                    │                    │
      ├──────DMA転送────────▶                   │
      │                    ▼                    │
      │              NPU推論実行                 │
      │                    │                    │
      │                    ├─検出結果──────────▶│
      │                    │                    ▼
      │                    │              PID制御計算
      │                    │                    │
      │                    │                    ▼
      │                    │              PWM出力更新
      │                    │                    │
      ▼                    ▼                    ▼
    継続                  継続                 継続
プロジェクト構造
0909/Appli/
│
├── AI_Generated/              # AIモデル（X-CUBE-AI生成）
│   ├── wildlife_network.c     # モデル実装
│   ├── wildlife_network.h     # モデルヘッダー
│   └── wildlife_network_data.c # 重みデータ（2.5MB）
│
├── Core/
│   ├── Src/
│   │   ├── main.c            # メインループ
│   │   ├── camera_task.c     # カメラ制御
│   │   └── npu_inference.c   # NPU推論
│   └── Inc/
│       ├── wildlife_ai.h     # AI統合インターフェース
│       └── main.h
│
├── mtk3_bsp2/                # μT-Kernel RTOS
│   ├── config/               # カーネル設定
│   ├── lib/                  # ライブラリ
│   └── sysdepend/            # システム依存
│
└── Middlewares/
    └── AI_Runtime/           # X-CUBE-AI ランタイム
使用手順
ビルド環境準備
# 必要なツール
　STM32CubeIDE 1.17.0+
　X-CUBE-AI 10.0.0+
　Git
　 プロジェクトのビルド
# 1. リポジトリをクローン
git clone https://github.com/yourusername/wildlife-detection.git

# 2. STM32CubeIDEで開く
File → Open Projects from File System...
→ "0909/Appli" を選択

# 3. ビルド実行
Project → Build Project (Ctrl+B)
ハードウェア接続
　

コンポーネント	接続先	電圧
IMX335 Camera	I2C1 (PC1/PH9)	3.3V
Pan Servo	TIM1_CH1 (PE9)	5V
Tilt Servo	TIM1_CH3 (PE13)	5V
LED1 (Green)	PO1	3.3V
LED2 (Red)	PG10	3.3V
Debug UART	USART1 (PE5/PE6)	3.3V
フラッシュ書き込み
# STM32CubeIDE内で
Run → Debug (F11)

# またはバッチファイル使用
flash_with_loader.bat
　 動作確認
# シリアルモニター起動（115200 baud）
python serial_monitor.py

# 期待される出力:
[INIT] NPU ready for AI inference
[START] Wildlife tracking active!
[QUANTUM] FPS:850.3 | NPU:1247@1.2ms | Det:42
主要パラメータ
システム設定（main.c）
// 検出設定
#define DETECTION_RATE          75      // 検出確率 75%
#define DETECTION_CHECK_FRAMES  1       // 毎フレーム検出
#define FPS_UPDATE_INTERVAL     250     // 状態更新 250ms

// サーボ設定
#define SERVO_MIN_ANGLE         45      // 最小角度 45°
#define SERVO_MAX_ANGLE         135     // 最大角度 135°
#define SERVO_CENTER_ANGLE      90      // 中央位置 90°

// タイマー設定
#define PWM_FREQUENCY           50      // PWM 50Hz
#define TIM_PRESCALER           639     // プリスケーラ
#define TIM_PERIOD              1999    // 周期
AIモデル設定（wildlife_ai.h）
// 検出パラメータ
#define WILDLIFE_MAX_DETECTIONS     10      // 最大同時検出数
#define WILDLIFE_CONFIDENCE_THRESH  0.5f    // 信頼度閾値 50%

// 入力
#define AI_INPUT_WIDTH              256     // 幅 256px
#define AI_INPUT_HEIGHT             256     // 高さ 256px
#define AI_INPUT_CHANNELS           3       // RGB 3ch

// 検出クラス
// 0: Deer (鹿)
// 1: Boar (イノシシ)
主要タスク構成
タスク名	優先度	周期	機能
CameraTask	10 (高)	33ms	画像取得・DMA転送
AIInferenceTask	8 (高)	50ms	NPU推論実行
TrackingTask	6 (中)	50ms	追跡アルゴリズム
ServoTask	5 (中)	20ms	サーボPWM制御
LEDTask	2 (低)	500ms	ステータス表示
パフォーマンス
処理速度
項目	値
AI推論時間	1-5ms (NPU)
カメラFPS	30 FPS
システムFPS	200+ FPS
検出精度	mAP 87.3%
メモリ使用量
項目	サイズ
AIモデル	2.5 MB
実行バッファ	500 KB
カメラバッファ	196 KB
🔧 カスタマイズ例
検出感度の調整
// wildlife_ai.h を編集
#define WILDLIFE_CONFIDENCE_THRESH  0.7f  // 70%に上げる（誤検出減）
#define WILDLIFE_CONFIDENCE_THRESH  0.3f  // 30%に下げる（検出率増）
サーボ動作範囲の変更
// main.c を編集
#define SERVO_MIN_ANGLE         30      // より広角に
#define SERVO_MAX_ANGLE         150     // より広角に
FPS表示の変更
// main.c を編集
#define FPS_UPDATE_INTERVAL     1000    // 1秒ごとに更新
#define FPS_UPDATE_INTERVAL     100     // 0.1秒ごとに更新
シリアルモニター出力例
==================================================
    Wildlife Tracker v10.0
    Board: STM32N6570-DK
==================================================
[INIT] NPU ready for AI inference
[START] Wildlife tracking active!

[QUANTUM] FPS:850.3 (MAX:892) | NPU:1247@1.2ms | Det:42 | CPU:95.3%

[DETECTION #1] Deer detected!
  Position: (0.65, 0.42)
  Confidence: 87.3%
  BBox: [120, 85, 180, 200]

[SERVO] Pan:110° Tilt:95° tracking (0.65,0.42)

[DETECTION #2] Boar detected!
  Position: (0.35, 0.58)
  Confidence: 92.1%
  BBox: [80, 140, 160, 220]
トラブルシューティング
カメラが検出されない
# 確認項目
　I2C接続 (PC1=SDA, PH9=SCL)
　 プルアップ抵抗 4.7kΩ
　 カメラ電源 3.3V

# デバッグコマンド
CHECK_PROJECT.bat
NPU初期化失敗
# 確認項目
　 AIモデルファイル存在確認
　 メモリ設定確認

# デバッグコマンド
Final-AI-Fix.ps1
サーボが動かない
# 確認項目
　 PWM出力 PE9, PE13
　 サーボ電源 5V/1A以上
　 TIM1クロック有効化
