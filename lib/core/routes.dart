import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

PageRouteBuilder customRoute(BuildContext context, {required Widget page}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeInLeft(child: child);
    },
  );
}

const splashScreenRoute = './splash';
const homePageRoute = './home';
const authPageRoutes = './auth';
const userInfoRoutes = './user_info';
const changePassRoutes = './change_pass';
const shippingAddressRoutes = './address';
const detailProductRoutes = './detail_product';
