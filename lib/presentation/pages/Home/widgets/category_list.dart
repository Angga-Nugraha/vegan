import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:vegan/core/routes.dart';

import '../../../../core/constant.dart';

class ListCategory extends StatelessWidget {
  const ListCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return FadeIn(
              duration: const Duration(seconds: 1),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, productViewRoutes,
                      arguments: category[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/img/${category[index]}.png'),
                          ),
                        ),
                      ),
                      Text(
                        category[index],
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: category.length,
        ));
  }
}
