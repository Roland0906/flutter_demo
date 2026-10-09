# 0003. Data layer with Dio + Fake Store API

- Status: Accepted
- Date: 2026-10-09

## Context

The demo needs real REST calls without maintaining its own backend.

## Decision

Call the public [Fake Store API](https://fakestoreapi.com) with Dio; `baseUrl` and timeouts are configured once in `dioProvider`. Checkout does not call an API — it simulates order submission with a delay.

## Consequences

- The full flow can be shown without a backend; switching to a real API only touches `dioProvider` and the model
- Depends on a third-party service, so each page needs an error view with retry
- Checkout does not reflect real order processing
