# Flutter Demo — E-commerce Shopping Flow

A Flutter e-commerce sample app covering the full shopping flow: **product list → product detail → cart → checkout**. Product data comes from the public [Fake Store API](https://fakestoreapi.com).

| Home | Product | Cart | Checkout |
| :---: | :---: | :---: | :---: |
| <img src="docs/screenshots/home.png" width="200"> | <img src="docs/screenshots/product.png" width="200"> | <img src="docs/screenshots/cart.png" width="200"> | <img src="docs/screenshots/checkout.png" width="200"> |

## Features

- **Product list**: responsive grid (column count adapts to screen width), pull to refresh, loading / error states with retry
- **Product detail**: image, category, rating, price, and description; add to cart in one tap (the SnackBar links straight to the cart)
- **Cart**: adjust quantities, items are removed at zero, live total; the app bar cart icon shows an item-count badge
- **Checkout**: order summary and total, simulated order submission (loading state, success dialog, cart cleared)

## Tech Stack

| Area | Choice |
| --- | --- |
| UI | Flutter · Material 3 |
| State management | [Riverpod 3](https://riverpod.dev) (`Notifier` / `FutureProvider`) |
| Routing | [go_router](https://pub.dev/packages/go_router) |
| Networking | [Dio](https://pub.dev/packages/dio) |
| Testing | flutter_test (widget test + cart unit tests) |

## Project Structure

```
lib/
├── main.dart              # App entry point and theme
├── router.dart            # Route definitions
├── data/api.dart          # Dio client and product data providers
├── models/product.dart    # Product model
├── state/cart.dart        # Cart state (CartNotifier) and derived providers
├── pages/                 # Home, product detail, cart, checkout
└── widgets/               # Shared widgets (cart button, error view, product image)
```

## Getting Started

Requires the Flutter SDK (Dart `^3.12.2`).

```bash
flutter pub get
flutter run            # pick a simulator, device, or Chrome
```

Run tests and static analysis:

```bash
flutter test
flutter analyze
```

## Notes

- Checkout is simulated; no order is actually submitted.
- Product data comes from a third-party public API. If the network is unavailable, the home and product pages show an error view with a retry button.
