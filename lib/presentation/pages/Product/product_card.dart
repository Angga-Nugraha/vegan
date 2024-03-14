import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/constant.dart';
import '../../../core/routes.dart';
import '../../../core/styles.dart';
import '../../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, detailProductRoutes, arguments: product);
      },
      child: SizedBox(
        height: 200,
        width: 150,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.5),
                    blurRadius: 5.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            imageUrl: convertUrl(product.imageUrl[0]),
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                  ),
                  Text(
                    product.title.toTitleCase(),
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Rp. ${product.price}',
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                height: 20,
                width: 40,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(15.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      product.ratting.toString(),
                      style: Theme.of(context).textTheme.bodySmall,
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
  }
}
