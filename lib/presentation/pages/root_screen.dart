import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan/data/utils/styles.dart';
import 'package:vegan/presentation/pages/Home/home_page.dart';

import '../bloc/product_bloc/product_bloc.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _initialIndex = 0;

  List<Widget> _listPage = [];

  @override
  void initState() {
    super.initState();
    _listPage = [
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
      const SizedBox(
        child: Center(
          child: Icon(Icons.account_circle_outlined),
        ),
      ),
    ];
    Future.microtask(() => BlocProvider.of<ProductBloc>(context, listen: false)
        .add(const FetchAllProduct()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listPage[_initialIndex],
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
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
        activeIndex: _initialIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        backgroundColor: foregroundColor,
        activeColor: backgroundColor,
        inactiveColor: primaryColor,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() {
          _initialIndex = index;
        }),
      ),
    );
  }
}
