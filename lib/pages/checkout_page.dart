import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../state/cart.dart';

/// Checkout: order summary + simulated "place order" (POST-style) submission.
class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  bool _placing = false;

  Future<void> _placeOrder() async {
    setState(() => _placing = true);
    // Simulate a POST /orders round-trip.
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    ref.read(cartProvider.notifier).clear();
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
        title: const Text('下單成功'),
        content: const Text('感謝購買！訂單已送出。'),
        actions: [
          FilledButton(
            onPressed: () => context.go('/'),
            child: const Text('回首頁'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lines = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('結帳')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('訂單明細', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...lines.map(
            (l) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${l.product.title}  ×${l.qty}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text('\$${l.subtotal.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),
          const Divider(height: 32),
          Row(
            children: [const Text('付款方式'), const Spacer(), const Text('貨到付款')],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('應付總額', style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: FilledButton(
            onPressed: (lines.isEmpty || _placing) ? null : _placeOrder,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            child: _placing
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('確認下單'),
          ),
        ),
      ),
    );
  }
}
