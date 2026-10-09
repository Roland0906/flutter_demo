# 0003. 資料層採用 Dio + Fake Store API

- 狀態：採用
- 日期：2026-10-09

## 背景

Demo 需要真實的 REST 呼叫，但不想維護自己的後端。

## 決策

以 Dio 呼叫公開的 [Fake Store API](https://fakestoreapi.com)，`baseUrl` 與逾時集中設定在 `dioProvider`。結帳不打 API，以延遲模擬送出訂單。

## 影響

- 無需後端即可展示完整流程；日後換成正式 API 只需調整 `dioProvider` 與 model
- 依賴第三方服務可用性，因此各頁需有錯誤畫面與重試
- 結帳流程不代表真實的訂單處理
