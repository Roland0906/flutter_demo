import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';

/// One line in the cart: a product plus its quantity.
class CartLine {
  final Product product;
  final int qty;
  const CartLine(this.product, this.qty);

  double get subtotal => product.price * qty;
}

/// Cart state, held as an ordered list of lines (Riverpod 3 Notifier API).
class CartNotifier extends Notifier<List<CartLine>> {
  @override
  List<CartLine> build() => const [];

  void add(Product p) {
    final idx = state.indexWhere((l) => l.product.id == p.id);
    if (idx >= 0) {
      final next = [...state];
      next[idx] = CartLine(p, next[idx].qty + 1);
      state = next;
    } else {
      state = [...state, CartLine(p, 1)];
    }
  }

  void changeQty(int productId, int delta) {
    final next = <CartLine>[];
    for (final l in state) {
      if (l.product.id == productId) {
        final q = l.qty + delta;
        if (q > 0) next.add(CartLine(l.product, q));
      } else {
        next.add(l);
      }
    }
    state = next;
  }

  void remove(int productId) =>
      state = state.where((l) => l.product.id != productId).toList();

  void clear() => state = const [];
}

final cartProvider =
    NotifierProvider<CartNotifier, List<CartLine>>(CartNotifier.new);

/// Total item count (for the app-bar badge).
final cartCountProvider = Provider<int>(
  (ref) => ref.watch(cartProvider).fold(0, (s, l) => s + l.qty),
);

/// Total price of everything in the cart.
final cartTotalProvider = Provider<double>(
  (ref) => ref.watch(cartProvider).fold(0.0, (s, l) => s + l.subtotal),
);
