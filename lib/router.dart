import 'package:go_router/go_router.dart';

import 'pages/cart_page.dart';
import 'pages/checkout_page.dart';
import 'pages/home_page.dart';
import 'pages/product_page.dart';

/// App navigation: home → product → cart → checkout.
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'product/:id',
          builder: (context, state) => ProductPage(
            id: int.parse(state.pathParameters['id']!),
          ),
        ),
        GoRoute(
          path: 'cart',
          builder: (context, state) => const CartPage(),
        ),
        GoRoute(
          path: 'checkout',
          builder: (context, state) => const CheckoutPage(),
        ),
      ],
    ),
  ],
);
