import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';

/// Shared Dio client pointed at the demo REST backend.
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://fakestoreapi.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
});

/// Product list for the home page.
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final dio = ref.watch(dioProvider);
  final res = await dio.get<List<dynamic>>('/products');
  return (res.data ?? [])
      .map((e) => Product.fromJson(e as Map<String, dynamic>))
      .toList();
});

/// Single product for the detail page.
final productProvider = FutureProvider.family<Product, int>((ref, id) async {
  final dio = ref.watch(dioProvider);
  final res = await dio.get<Map<String, dynamic>>('/products/$id');
  return Product.fromJson(res.data!);
});
