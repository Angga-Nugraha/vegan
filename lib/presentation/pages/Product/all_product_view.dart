import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan/domain/entities/product.dart';
import 'package:vegan/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:vegan/presentation/pages/Product/product_grid.dart';

import '../components/components_helper.dart';

class ProductView extends StatefulWidget {
  const ProductView({required this.category, super.key});

  final String category;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late List<Product> listProduct;

  @override
  void initState() {
    if (widget.category != "Top Rated" || widget.category != "All Product") {
      // TODO: Something
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: () {
        switch (widget.category) {
          case "Top Rated":
            return BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                switch (state) {
                  case ProductLoading():
                    return listShimmer();
                  case ProductLoaded():
                    listProduct = state.result
                        .map((e) => e)
                        .where((element) => element.ratting > 4)
                        .toList();
                    return listProduct.isEmpty
                        ? const Center(
                            child: Text('Product is empty'),
                          )
                        : ProductGrid(listProduct: listProduct);
                  case ProductError():
                    return Text(state.message);
                  default:
                    return const Center(child: Text("Error"));
                }
              },
            );
          case "All Product":
            return BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                switch (state) {
                  case ProductLoading():
                    return listShimmer();
                  case ProductLoaded():
                    listProduct = state.result;
                    return listProduct.isEmpty
                        ? const Center(
                            child: Text('Product is empty'),
                          )
                        : ProductGrid(listProduct: listProduct);
                  case ProductError():
                    return Text(state.message);
                  default:
                    return const Center(child: Text("Error"));
                }
              },
            );
          default:
            return Text(widget.category);
        }
      }(),
    );
  }
}
