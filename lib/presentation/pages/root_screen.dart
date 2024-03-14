import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
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

  Future<void> getPermission() async {
    var permission = await Permission.location.status;
    if (permission == PermissionStatus.denied) {
      permission = await Permission.location.request();
    }
  }

  @override
  void initState() {
    Future.microtask(() {
      return [
        BlocProvider.of<UserBloc>(context, listen: false)
            .add(const FetchCurrentUser()),
        BlocProvider.of<ProductBloc>(context, listen: false)
            .add(const FetchAllProduct()),
        getPermission(),
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listPage[_initialIndex],
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(
          side: BorderSide(
            width: 3.0,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        onPressed: () {},
        child: const Icon(Icons.shopping_cart_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.home_outlined,
          Icons.assignment_outlined,
          Icons.bookmark_border,
          Icons.account_circle_outlined
        ],
        blurEffect: true,
        iconSize: 22,
        activeIndex: _initialIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        backgroundColor: Theme.of(context).colorScheme.primary,
        activeColor: backgroundColor,
        inactiveColor: kPrussianBlue,
        onTap: (index) => setState(() {
          _initialIndex = index;
        }),
      ),
    );
  }
}
