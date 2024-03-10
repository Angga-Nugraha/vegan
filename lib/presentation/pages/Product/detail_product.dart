import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:vegan/core/constant.dart';
import 'package:vegan/presentation/pages/Product/product_card.dart';

import '../../../core/styles.dart';
import '../../../domain/entities/product.dart';

class DetailProduct extends StatelessWidget {
  final Product product;

  const DetailProduct({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 2,
                    child: Swiper(
                      outer: true,
                      itemCount: product.imageUrl.length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: convertUrl(product.imageUrl[index]),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      scale: 0.5,
                      pagination: const SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: SwiperPagination.rect,
                      ),
                    ),
                  ),
                  FadeInUp(
                    child: Container(
                      padding:
                          const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 100.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: foregroundColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30.0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              product.title.toTitleCase(),
                              style:
                                  titleStyle.copyWith(color: backgroundColor),
                            ),
                            subtitle: Text(
                              "Rp. ${product.price.toString().toTitleCase()} / ${product.weight}kg",
                              style: subTitleStyle.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: backgroundColor),
                            ),
                            trailing: RatingBarIndicator(
                              rating: product.ratting,
                              itemCount: 5,
                              itemSize: 15,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 10),
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Deskripsi Produk",
                                  style: subTitleStyle.copyWith(
                                      color: backgroundColor),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  product.description.toCapitalized(),
                                  style: bodyTextStyle.copyWith(
                                      color: backgroundColor),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Ketersedian Produk : ${product.stock} item",
                                  style: bodyTextStyle.copyWith(
                                      color: backgroundColor),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          const SizedBox(height: 10),
                          Text(
                            "Rekomendasi Produk",
                            style:
                                subTitleStyle.copyWith(color: backgroundColor),
                          ),
                          const SizedBox(height: 10),
                          const ProductListCardItem(category: "Top Product"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey.shade200)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const Spacer(),
                  IconButton(
                      style: ButtonStyle(
                          foregroundColor:
                              const MaterialStatePropertyAll(Colors.red),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey.shade200)),
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_outline))
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: foregroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.shopping_cart_outlined),
                            Text("Add to Cart"),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                          foregroundColor: backgroundColor),
                      onPressed: () {},
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Checkout"),
                            Icon(Icons.arrow_circle_right_outlined),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}