# STM32N6 YOLO Project - Build Fix Summary

## ✅ 修正完了 - Version 3.0

### 🎯 解決した問題

1. **`duplicate 'extern'` エラー**
   - 原因: Neural-ARTマクロの重複宣言
   - 解決: マクロ宣言を削除し、スタブ実装のみを提供

2. **未定義変数の警告**
   - 原因: `NN_Instance_yolo_deer`の未使用
   - 解決: Neural-ART実装をコメントアウトし、スタブモードを使用

3. **RAMオーバーフロー**
   - 原因: 11.5MBの重みデータ
   - 解決: yolo_deer.cを無効化

### 📁 ファイル変更内容

#### 修正されたファイル:
- `yolo_deer_stub.c` - Neural-ARTマクロを削除、純粋なスタブ実装
- `app_x-cube-ai.c` - Neural-ART呼び出しをスタブ化
- `app_x-cube-ai.h` - ヘッダーファイルを追加
- `yolo_deer_data_params.c` - サイズを縮小（ビルドテスト用）
- `yolo_deer_data_params.h` - 互換性のある型定義

#### 無効化されたファイル:
- `yolo_deer.c` → `yolo_deer.c.disabled`

### 🚀 実行手順

```cmd
# 1. FSBLディレクトリに移動
cd C:\Users\iniad\STM32CubeIDE\workspace_2\mtk3bsp2_stm32n657\FSBL

# 2. 修正スクリプトを実行
final_build_fix.bat

# 3. STM32CubeIDEで:
#    - プロジェクトをリフレッシュ (F5)
#    - Project → Clean
#    - Project → Build Project
```

### 🔧 コンパイラ設定

STM32CubeIDEで以下を確認:

1. **Preprocessor Macros**:
   ```
   STUB_MODE=1
   USE_NPU_RAMS=1
   USE_EXTERNAL_FLASH_FOR_WEIGHTS=1
   ```

2. **Linker Script**:
   - 使用: `STM32N657X0HXQ_AXISRAM2_fsbl.ld` (デフォルト)
   - または: `STM32N657X0HXQ_AXISRAM2_fsbl_optimized.ld` (最適化版)

3. **Source Files**:
   - 含める: `yolo_deer_stub.c`
   - 除外: `yolo_deer.c`

### 📊 期待されるビルド結果

```
Build Finished. 0 errors, X warnings.

Memory region         Used Size  Region Size  %age Used
           ROM:        ~240 KB      255 KB      ~94%
           RAM:        ~230 KB      256 KB      ~90%
```

### ⚡ パフォーマンス最適化（将来）

現在はスタブモードで動作。実際のAI推論を有効にするには:

1. X-CUBE-AIで完全な重みデータを生成
2. 外部フラッシュ（0x71000000）に書き込み
3. `STUB_MODE`を無効化
4. Neural-ART実装を有効化

### 🆘 トラブルシューティング

| エラー | 解決方法 |
|--------|----------|
| `undefined reference to ai_*` | `STUB_MODE=1`を定義 |
| `yolo_deer.c` errors | ファイルを`.disabled`にリネーム |
| リンカエラー | クリーンビルドを実行 |
| Neural-ART warnings | 現時点では無視可能 |

### 📝 Notes

- このビルドは**テスト用**です
- 実際のAI推論には追加の実装が必要
- Neural-ART NPUは初期化されますが、実際の推論は実行されません

---
**Last Updated**: 2025-09-28
**Version**: 3.0
**Status**: ✅ Build Ready
