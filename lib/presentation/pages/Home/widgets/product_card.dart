import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../data/utils/constant.dart';
import '../../../../data/utils/styles.dart';
import '../../../../domain/entities/product.dart';

class ProductCardItem extends StatelessWidget {
  final Product product;

  ProductCardItem({
    super.key,
    required this.product,
  });

  final GlobalKey widgetKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {},
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide()),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            elevation: 2,
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: 150,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: product.imageUrl.isEmpty
                            ? Image.asset(
                                'assets/img/nopic.png',
                                width: 100,
                                height: 120,
                              )
                            : CachedNetworkImage(
                                height: 120,
                                width: 100,
                                fit: BoxFit.contain,
                                imageUrl: convertUrl(product.imageUrl[0]),
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                      ),
                      Expanded(
                        child: Text(
                          product.title.toTitleCase(),
                          style: subTitleStyle.copyWith(color: primaryColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Berat ${product.weight.toString()} Kg',
                          style: bodyTextStyle,
                        ),
                      ),
                      Card(
                        color: secondaryColor,
                        child: Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Rp. ${product.price}',
                            style:
                                subTitleStyle.copyWith(color: backgroundColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: -1,
                  top: -1,
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                      )),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            maximumSize: const Size(150, 50),
            minimumSize: const Size(150, 20),
          ),
          child: const Text('Add To Cart'),
        )
      ],
    );
  }
}
