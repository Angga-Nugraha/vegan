import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../bloc/auth_bloc/auth_bloc.dart';
import 'Auth/auth_page.dart';
import 'Auth/login_page.dart';
import 'Auth/register_page.dart';
import 'Home/home_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 5)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: 150,
                child: Lottie.asset('assets/lottie/splash.json'),
              ),
            );
          } else {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                switch (state) {
                  case Authenticated():
                    return const HomePage();
                  case Unauthenticated():
                    return const AuthPage(
                      listPage: [
                        LoginPage(),
                        RegisterPage(),
                      ],
                    );
                  default:
                    return const AuthPage(
                      listPage: [
                        LoginPage(),
                        RegisterPage(),
                      ],
                    );
                }
              },
            );
          }
        },
      ),
    );
  }
}
