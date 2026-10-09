# 0001. State management with Riverpod

- Status: Accepted
- Date: 2026-10-09

## Context

The cart is shared across pages (app bar badge, cart page, checkout page). Product data needs loading and error states, and must be replaceable in tests.

## Decision

Use Riverpod 3: a `Notifier` for the cart, `FutureProvider` for API data, and derived `Provider`s for item count and total.

## Consequences

- Loading / error / data states are handled uniformly with `AsyncValue.when`; retry is just `ref.invalidate`
- Tests use `ProviderScope` overrides or a `ProviderContainer`, with no real API calls
- One more concept than `setState`, but less boilerplate than Bloc
