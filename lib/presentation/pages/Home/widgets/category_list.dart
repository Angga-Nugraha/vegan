import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant.dart';

class ListCategory extends StatelessWidget {
  const ListCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  FadeIn(
                    duration: const Duration(seconds: 1),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/img/${category[index]}.png'),
                        ),
                      ),
                    ),
                  ),
                  FadeIn(
                    duration: const Duration(seconds: 1),
                    child: Text(
                      category[index],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: category.length,
        ));
  }
}
