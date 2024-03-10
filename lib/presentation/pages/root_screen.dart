import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan/core/styles.dart';
import 'package:vegan/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:vegan/presentation/pages/Home/home_page.dart';
import 'package:vegan/presentation/pages/Profile/profile_page.dart';

import '../bloc/product_bloc/product_bloc.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _initialIndex = 0;

  final List<Widget> _listPage = [
    const MyHomePage(),
    const SizedBox(
      child: Center(
        child: Icon(Icons.assignment_outlined),
      ),
    ),
    const SizedBox(
      child: Center(
        child: Icon(Icons.person),
      ),
    ),
    const ProfilePage(),
  ];

  @override
  void initState() {
    Future.microtask(() {
      return [
        BlocProvider.of<UserBloc>(context, listen: false)
            .add(const FetchCurrentUser()),
        BlocProvider.of<ProductBloc>(context, listen: false)
            .add(const FetchAllProduct()),
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listPage[_initialIndex],
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(
            side: BorderSide(
              color: foregroundColor,
              width: 3.0,
            ),
          ),
          backgroundColor: backgroundColor,
          foregroundColor: primaryColor,
          onPressed: () {},
          child: const Icon(Icons.shopping_cart_outlined)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.home_outlined,
          Icons.assignment_outlined,
          Icons.account_circle_outlined,
          Icons.account_circle_outlined
        ],
        iconSize: 22,
        activeIndex: _initialIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        backgroundColor: foregroundColor,
        activeColor: backgroundColor,
        inactiveColor: primaryColor,
        leftCornerRadius: 10.0,
        rightCornerRadius: 10.0,
        onTap: (index) => setState(() {
          _initialIndex = index;
        }),
      ),
    );
  }
}
