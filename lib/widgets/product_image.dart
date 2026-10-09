import 'package:flutter/material.dart';

/// Network product image with a placeholder when the image fails to load.
class ProductImage extends StatelessWidget {
  const ProductImage(this.url, {super.key, this.width, this.fit});
  final String url;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      fit: fit,
      errorBuilder: (context, _, _) => SizedBox(
        width: width,
        child: Icon(
          Icons.image_not_supported_outlined,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }
}
