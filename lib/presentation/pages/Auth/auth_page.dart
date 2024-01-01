import 'package:flutter/material.dart';

import '../../../data/utils/routes.dart';

class AuthPage extends StatefulWidget {
  final List<Widget> listPage;
  const AuthPage({required this.listPage, super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [...widget.listPage],
      ),
    );
  }
}
