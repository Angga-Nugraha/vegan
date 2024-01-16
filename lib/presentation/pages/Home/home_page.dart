import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vegan/data/utils/routes.dart';
import 'package:vegan/presentation/bloc/product_bloc/product_bloc.dart';

import '../../../data/utils/styles.dart';
import '../components/components_helper.dart';
import 'widgets/category_list.dart';
import 'widgets/discount_card.dart';
import 'widgets/product_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 120,
              floating: true,
              backgroundColor: foregroundColor,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/img/3.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 20,
                      child: Text(
                        'Welcome to Vegan',
                        style: titleStyle.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                title: SizedBox(
                  height: 25,
                  width: MediaQuery.of(context).size.width - 120,
                  child: myTextfield(
                      enabled: false,
                      controller: searchController,
                      hintText: 'Search',
                      icon: Icons.search,
                      type: TextInputType.text),
                ),
                titlePadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              ),
              actions: [
                GestureDetector(
                  child: const Icon(
                    FontAwesomeIcons.message,
                    color: backgroundColor,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 15.0),
                GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      FontAwesomeIcons.bell,
                      color: backgroundColor,
                      size: 16,
                    )),
                const SizedBox(width: 20.0),
              ],
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () async =>
              context.read<ProductBloc>().add(const FetchAllProduct()),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ListCategory(),
                const DiscountCard(),
                _headers(
                    title: 'Top Rated',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, authPageRoutes);
                    }),
                const Divider(),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    switch (state) {
                      case ProductLoading():
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ProductLoaded():
                        final toprated = state.result
                            .map((e) => e)
                            .where((element) => element.ratting > 4)
                            .toList();
                        return toprated.isEmpty
                            ? const Center(
                                child: Text('Product is empty'),
                              )
                            : SizedBox(
                                height: 280,
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: toprated.length,
                                    padding: const EdgeInsets.all(8.0),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final product = toprated[index];

                                      return ProductCardItem(
                                        product: product,
                                      );
                                    }),
                              );
                      case ProductError():
                        return Text(state.message);
                      default:
                        return Container();
                    }
                  },
                ),
                _headers(title: 'All Product', onPressed: () {}),
                const Divider(),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    switch (state) {
                      case ProductLoading():
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ProductLoaded():
                        final allProduct = state.result;
                        return allProduct.isEmpty
                            ? const Center(
                                child: Text('Product is empty'),
                              )
                            : SizedBox(
                                height: 280,
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: allProduct.length,
                                    padding: const EdgeInsets.all(8.0),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final product = allProduct[index];
                                      return ProductCardItem(
                                        product: product,
                                      );
                                    }),
                              );
                      case ProductError():
                        return Text(state.message);
                      default:
                        return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headers(
      {String? title, String? trailingTitle, VoidCallback? onPressed}) {
    return ListTile(
      titleTextStyle: titleStyle.copyWith(fontSize: 18),
      textColor: primaryColor,
      title: Text(
        title ?? '',
      ),
      trailing: GestureDetector(
        onTap: onPressed ?? () {},
        child: Text(
          trailingTitle ?? 'View all...',
          style: subTitleStyle.copyWith(fontSize: 12),
        ),
      ),
    );
  }
}
