# 0002. Routing with go_router

- Status: Accepted
- Date: 2026-10-09

## Context

The flow is home → product → cart → checkout. The product page takes a parameter, and the app should also run on the web.

## Decision

Use go_router with declarative routes; the product page lives at `/product/:id`. Forward navigation uses `push` (keeps the back stack); returning home uses `go('/')` (clears it).

## Consequences

- Routes are defined in one place (`router.dart`); web URLs and deep links work out of the box
- `push` and `go` have different semantics; mixing them up breaks back-button behavior
