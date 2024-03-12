import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../../../../core/styles.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(seconds: 1),
      child: SizedBox(
        height: 150,
        child: Swiper(
          itemCount: 3,
          autoplay: true,
          itemBuilder: (context, index) {
            return Card(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset('assets/img/banner.png',
                    width: MediaQuery.of(context).size.width - 30,
                    fit: BoxFit.cover),
              ),
            );
          },
          scale: 0.5,
          pagination: const SwiperPagination(
            alignment: Alignment.bottomLeft,
            builder: RectSwiperPaginationBuilder(
              color: kDavysGrey,
              activeColor: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
