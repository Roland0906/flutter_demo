import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/api.dart';
import '../state/cart.dart';
import '../widgets/cart_button.dart';
import '../widgets/error_view.dart';
import '../widgets/product_image.dart';

/// Product detail with an "add to cart" action.
class ProductPage extends ConsumerWidget {
  const ProductPage({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productProvider(id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品詳情'),
        actions: const [CartButton()],
      ),
      body: product.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(
          message: '$e',
          onRetry: () => ref.invalidate(productProvider(id)),
        ),
        data: (p) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(24),
                child: ProductImage(p.image, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 16),
            Chip(label: Text(p.category)),
            const SizedBox(height: 8),
            Text(p.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, size: 18, color: Colors.amber),
                Text(' ${p.rating}'),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '\$${p.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(p.description),
          ],
        ),
      ),
      bottomNavigationBar: product.maybeWhen(
        data: (p) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: FilledButton.icon(
              onPressed: () {
                ref.read(cartProvider.notifier).add(p);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: const Text('已加入購物車'),
                      duration: const Duration(seconds: 1),
                      action: SnackBarAction(
                        label: '查看',
                        onPressed: () => context.go('/cart'),
                      ),
                    ),
                  );
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('加入購物車'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
            ),
          ),
        ),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}
