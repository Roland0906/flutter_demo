# 0001. 狀態管理採用 Riverpod

- 狀態：採用
- 日期：2026-10-09

## 背景

購物車需要跨頁共享（App Bar 件數、購物車頁、結帳頁），商品資料需要處理載入中 / 錯誤狀態，且要能在測試中替換。

## 決策

使用 Riverpod 3：購物車用 `Notifier`，API 資料用 `FutureProvider`，件數與合計用衍生 `Provider`。

## 影響

- 載入 / 錯誤 / 資料三態由 `AsyncValue.when` 統一處理，重試只需 `ref.invalidate`
- 測試可用 `ProviderScope` override 或 `ProviderContainer`，不需打真實 API
- 相較 `setState` 多一層概念，但比 Bloc 樣板少
