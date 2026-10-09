# 0004. 不使用程式碼產生

- 狀態：採用
- 日期：2026-10-09

## 背景

json_serializable、freezed、riverpod_generator 能減少樣板，但需要 build_runner 與產生檔。

## 決策

目前規模小（1 個 model、少量 provider），手寫 `fromJson` 與 provider，不引入程式碼產生。

## 影響

- `flutter pub get` 後即可執行，沒有產生檔需要同步
- Model 或 provider 數量明顯增加時，應重新評估此決策
