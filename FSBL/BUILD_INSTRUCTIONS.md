# STM32N6 YOLO Deer Detection - ビルド修正手順

## 問題の概要
STM32N6のX-CUBE-AI統合において、以下の問題が発生していました：
- RAMオーバーフロー（約1.9MB）
- 不適切なメモリレイアウト
- AIモデルの重みデータが内部RAMに配置される問題

## 修正内容

### 1. リンカスクリプトの修正
**ファイル**: `STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld`

#### 主な変更点：
- STM32N6の全メモリ領域を正しく定義
- 外部メモリ（XSPI1/XSPI2）を追加
- NPU RAM（AXISRAM3-6）を個別に定義
- AI重みデータを外部フラッシュ（XSPI2）に配置
- アクティベーションバッファをAXISRAM2に配置

### 2. app_x-cube-ai.cの修正
#### 主な変更点：
- AXISRAM1の有効化を追加
- RAMCFG_SRAM1_AXIの初期化を追加
- 外部メモリインターフェース（XSPI1/2）の有効化
- キャッシュ（CACHEAXI）の有効化
- メモリセクション属性の追加

## ビルド手順

### STM32CubeIDEでの設定

1. **プロジェクトのプロパティを開く**
   - プロジェクトを右クリック → Properties

2. **リンカスクリプトの変更**
   - C/C++ Build → Settings → Tool Settings タブ
   - MCU GCC Linker → General
   - Linker Script フィールドで以下に変更：
     ```
     ${workspace_loc:/${ProjName}/STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld}
     ```

3. **ビルド設定の確認**
   - C/C++ Build → Settings → Tool Settings タブ
   - MCU Settings で以下を確認：
     - Board: STM32N6570-DK
     - Use float with printf: チェック

4. **最適化オプション**
   - MCU GCC Compiler → Optimization
   - Optimization Level: Optimize for size (-Os)
   - その他のフラグ:
     ```
     -ffunction-sections -fdata-sections
     ```

5. **リンカーオプション**
   - MCU GCC Linker → Miscellaneous
   - Other flags に以下を追加：
     ```
     -Wl,--gc-sections -Wl,--print-memory-usage
     ```

### ビルド実行

1. **クリーンビルド**
   ```
   Project → Clean... → Clean all projects
   ```

2. **ビルド**
   ```
   Project → Build Project
   ```

## トラブルシューティング

### エラー: region 'RAM' overflowed
**原因**: 古いリンカスクリプトが使用されている
**解決**: 上記手順2を確認し、正しいリンカスクリプトを指定

### エラー: undefined reference to `RAMCFG_SRAM1_AXI`
**原因**: HALドライバのバージョンが古い
**解決**: STM32CubeMXで最新のファームウェアパッケージに更新

### 警告: section `.ai_weights` not found
**原因**: yolo_deer.cファイルが正しくコンパイルされていない
**解決**: yolo_deer.cファイルで重みデータにセクション属性を追加

## メモリ使用状況の確認

ビルド成功後、以下のメモリ使用状況が表示されるはずです：
```
Memory region         Used Size  Region Size  %age Used
           ROM:       xxxxx B       255 KB      xx.xx%
           RAM:       xxxxx B       256 KB      xx.xx%
      AXISRAM2:       xxxxx B      1024 KB      xx.xx%
       NPURAM3:           0 B       448 KB       0.00%
       NPURAM4:           0 B       448 KB       0.00%
       NPURAM5:           0 B       448 KB       0.00%
       NPURAM6:           0 B       448 KB       0.00%
         XSPI1:           0 B        32 MB       0.00%
         XSPI2:     11.5 MB B       128 MB       8.98%
```

## 追加の最適化（オプション）

### yolo_deer.cの修正が必要な場合
大きな配列定義に以下の属性を追加：
```c
__attribute__((section(".xspi2_data")))
const uint8_t yolo_deer_weights[] = { /* ... */ };
```

### 実行時のパフォーマンス改善
1. NPUクロックを最大化（800MHz → 1GHz）
2. キャッシュの最適化
3. DMAチャネルの設定

## 参考資料
- STM32N6 Reference Manual (RM0408)
- X-CUBE-AI User Manual (UM2526)
- ST Neural-ART Programming Guide
