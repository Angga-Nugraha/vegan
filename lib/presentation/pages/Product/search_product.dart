import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product_bloc/product_bloc.dart';
import '../components/components_helper.dart';
import 'product_grid.dart';

class SearchProductPage extends StatelessWidget {
  SearchProductPage({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        title: Container(
          height: 25,
          width: MediaQuery.of(context).size.width - 120,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 2,
              ),
            ],
          ),
          child: myTextfield(
            context,
            controller: searchController,
            border: InputBorder.none,
            hintext: "Search",
            icon: Icons.search,
            type: TextInputType.text,
            onChanged: (query) {
              if (query.isNotEmpty) {
                context.read<SearchBloc>().add(SearchProductEvent(query));
              }
            },
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.shopping_cart_outlined),
          ),
          const SizedBox(width: 20)
        ],
      ),
      body: BlocBuilder<SearchBloc, ProductState>(
        builder: (context, state) {
          switch (state) {
            case ProductLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ProductLoaded():
              final listProduct = state.result;
              if (state.result.isEmpty) {
                return const Center(child: Text("Result not found"));
              } else {
                return ProductGrid(listProduct: listProduct);
              }
            case ProductError():
              return Center(
                child: Text(state.message),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
