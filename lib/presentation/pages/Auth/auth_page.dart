import 'package:flutter/material.dart';

import '../../../core/constant.dart';

class AuthPage extends StatefulWidget {
  final List<Widget> listPage;
  const AuthPage({required this.listPage, super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [...widget.listPage],
        ),
      ),
    );
  }
}
