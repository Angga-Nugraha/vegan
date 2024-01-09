import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../../data/utils/constant.dart';
import '../../../../data/utils/styles.dart';

class ListCategory extends StatelessWidget {
  const ListCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(
          category.length,
          (index) => FadeInLeft(
            duration: const Duration(seconds: 1),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/${category[index]}.png'),
                    ),
                  ),
                ),
                Text(
                  category[index],
                  style: bodyTextStyle,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
