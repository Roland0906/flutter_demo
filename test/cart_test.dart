import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_demo/models/product.dart';
import 'package:flutter_demo/state/cart.dart';

Product _product(int id, double price) => Product(
      id: id,
      title: 'Product $id',
      price: price,
      description: '',
      category: '',
      image: '',
      rating: 0,
    );

void main() {
  late ProviderContainer container;
  late CartNotifier cart;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
    cart = container.read(cartProvider.notifier);
  });

  test('starts empty', () {
    expect(container.read(cartProvider), isEmpty);
    expect(container.read(cartCountProvider), 0);
    expect(container.read(cartTotalProvider), 0);
  });

  test('adding the same product twice increments its quantity', () {
    final p = _product(1, 10);
    cart.add(p);
    cart.add(p);

    final lines = container.read(cartProvider);
    expect(lines, hasLength(1));
    expect(lines.single.qty, 2);
  });

  test('count and total reflect every line', () {
    cart.add(_product(1, 10));
    cart.add(_product(1, 10));
    cart.add(_product(2, 2.5));

    expect(container.read(cartCountProvider), 3);
    expect(container.read(cartTotalProvider), 22.5);
  });

  test('changeQty removes a line when quantity drops to zero', () {
    cart.add(_product(1, 10));
    cart.add(_product(2, 5));
    cart.changeQty(1, -1);

    final lines = container.read(cartProvider);
    expect(lines.map((l) => l.product.id), [2]);
  });

  test('remove and clear', () {
    cart.add(_product(1, 10));
    cart.add(_product(2, 5));

    cart.remove(1);
    expect(container.read(cartProvider).map((l) => l.product.id), [2]);

    cart.clear();
    expect(container.read(cartProvider), isEmpty);
  });
}
