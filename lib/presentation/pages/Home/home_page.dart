import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vegan/data/utils/constant.dart';
import 'package:vegan/data/utils/routes.dart';
import 'package:vegan/presentation/bloc/product_bloc/product_bloc.dart';

import '../../../data/utils/styles.dart';
import '../../bloc/user_bloc/user_bloc.dart';
import '../components/components_helper.dart';
import 'widgets/category_list.dart';
import 'widgets/discount_card.dart';
import 'widgets/product_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Container(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(colors: [
                          Colors.transparent,
                          Colors.black26,
                        ], radius: 1),
                      ),
                    ),
                    Positioned(
                      top: 25,
                      left: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to Vegan,',
                            style: titleStyle.copyWith(color: Colors.white),
                          ),
                          BlocConsumer<UserBloc, UserState>(
                            listener: (context, state) {
                              if (state is UserError) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                        state.message.toTitleCase(),
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushReplacementNamed(
                                                  context, authPageRoutes);
                                            },
                                            child: const Text("Oke"))
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            builder: (context, state) {
                              switch (state) {
                                case UserLoaded():
                                  String? user =
                                      state.result.name?.toTitleCase();
                                  return FadeIn(
                                    duration: const Duration(milliseconds: 500),
                                    child: Text(
                                      user ?? '',
                                      style: subTitleStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  );
                                default:
                                  return const SizedBox();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                title: Container(
                  height: 25,
                  width: MediaQuery.of(context).size.width - 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(1, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        size: 14,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Search",
                        style: bodyTextStyle.copyWith(color: Colors.grey),
                      )
                    ],
                  ),
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
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            physics: const BouncingScrollPhysics(),
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ListCategory(),
              const DiscountCard(),
              _headers(title: 'Top Rated', onPressed: () {}),
              const Divider(),
              _buildListProduct("Top Rated"),
              _headers(title: 'All Product', onPressed: () {}),
              const Divider(),
              _buildListProduct("All Product"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListProduct(String category) {
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
                    height: 250,
                    child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: listProduct.length,
                        padding: const EdgeInsets.all(8.0),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final product = listProduct[index];

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
