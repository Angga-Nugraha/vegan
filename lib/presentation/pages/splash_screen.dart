import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vegan/presentation/pages/root_screen.dart';

import '../../data/helpers/storage_helper.dart';
import '../../data/utils/styles.dart';
import 'Auth/auth_page.dart';
import 'Auth/widgets/login_page.dart';
import 'Auth/widgets/register_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final SecureStorageHelper storage = SecureStorageHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future<String?>.delayed(const Duration(seconds: 5), () {
          return storage.readData('auth');
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 2500),
                builder: (context, value, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Lottie.asset('assets/lottie/splash.json'),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                                    colors: [secondaryColor, Colors.white])
                                .createShader(bounds);
                          },
                          child: LinearProgressIndicator(
                            value: value,
                          ),
                        ),
                      ),
                      Text(
                        '${(value * 100).toInt()}%',
                        style: subTitleStyle,
                      )
                    ],
                  );
                },
              ),
            );
          } else if (snapshot.hasData) {
            final data = json.decode(snapshot.data!);
            if (data['status'] == 'success') {
              return const RootScreen();
            } else {
              return const AuthPage(
                listPage: [
                  LoginPage(),
                  RegisterPage(),
                ],
              );
            }
          } else {
            return const AuthPage(
              listPage: [
                LoginPage(),
                RegisterPage(),
              ],
            );
          }
        },
      ),
    );
  }
}
