import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant.dart';
import '../../../core/routes.dart';
import '../../../core/styles.dart';
import '../../bloc/product_bloc/product_bloc.dart';
import '../components/components_helper.dart';

class ProductListCardItem extends StatelessWidget {
  const ProductListCardItem({
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
                        padding: const EdgeInsets.all(8.0),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final product = listProduct[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, detailProductRoutes,
                                  arguments: product);
                            },
                            child: Card(
                              surfaceTintColor: backgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.only(right: 20.0),
                              shadowColor: foregroundColor,
                              elevation: 5,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: 150,
                                    height: 180,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          child: product.imageUrl.isEmpty
                                              ? Image.asset(
                                                  'assets/img/nopic.png',
                                                  width: 80,
                                                )
                                              : CachedNetworkImage(
                                                  height: 100,
                                                  fit: BoxFit.contain,
                                                  imageUrl: convertUrl(
                                                      product.imageUrl[0]),
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                        ),
                                        Text(
                                          product.title.toTitleCase(),
                                          style: subTitleStyle.copyWith(
                                              color: primaryColor),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          surfaceTintColor: secondaryColor,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Text(
                                              'Rp. ${product.price}',
                                              style: subTitleStyle,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      height: 20,
                                      decoration: const BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(15.0))),
                                      child: Row(
                                        children: [
                                          Text(
                                            product.ratting.toString(),
                                            style: bodyTextStyle.copyWith(
                                              color: backgroundColor,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.star,
                                            color: processColor,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
}
