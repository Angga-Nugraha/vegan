import 'package:flutter/material.dart';

import '../../../data/utils/routes.dart';

class AuthPage extends StatelessWidget {
  final List<Widget> listPage;
  const AuthPage({required this.listPage, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [...listPage],
      ),
    );
  }
}
