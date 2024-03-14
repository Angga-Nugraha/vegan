import 'package:flutter/material.dart';
import 'package:vegan/presentation/pages/Product/product_card.dart';

import '../../../domain/entities/product.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.listProduct,
  });

  final List<Product> listProduct;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        final product = listProduct[index];
        return ProductCard(product: product);
      },
      itemCount: listProduct.length,
    );
  }
}
