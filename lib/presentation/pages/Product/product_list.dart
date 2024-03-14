import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product_bloc/product_bloc.dart';
import '../components/components_helper.dart';
import 'product_card.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    required this.category,
    super.key,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        switch (state) {
          case ProductLoading():
            return listShimmer();
          case ProductLoaded():
            final listProduct = category == "All Product"
                ? state.result
                : state.result
                    .map((e) => e)
                    .where((element) => element.ratting > 4)
                    .toList();
            return listProduct.isEmpty
                ? const Center(
                    child: Text('Product is empty'),
                  )
                : SizedBox(
                    height: 220,
                    child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: listProduct.length,
                        padding: const EdgeInsets.all(10.0),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final product = listProduct[index];

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: ProductCard(product: product),
                          );
                        }),
                  );
          case ProductError():
            return Text(state.message);
          default:
            return const Center(
              child: Text("Error"),
            );
        }
      },
    );
  }
}
