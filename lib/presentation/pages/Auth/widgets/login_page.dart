import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:vegan/core/routes.dart';

import '../../../../core/constant.dart';
import '../../../../core/styles.dart';
import '../../../bloc/auth_bloc/auth_bloc.dart';
import '../../components/components_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool vissible = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(
            height: 180,
            child: Lottie.asset(
              'assets/lottie/login.json',
            ),
          ),
          const SizedBox(height: 50),
          FadeIn(
            duration: const Duration(seconds: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Vegan',
                  style: titleStyle,
                ),
                Text('Sign in to your account', style: subTitleStyle),
              ],
            ),
          ),
          const SizedBox(height: 10),
          FadeInLeft(
            duration: const Duration(seconds: 1),
            child: myTextfield(
              controller: _emailController,
              hintText: 'Email/Phone',
              icon: Icons.email_outlined,
              type: TextInputType.emailAddress,
            ),
          ),
          const SizedBox(height: 20),
          FadeInRight(
            duration: const Duration(seconds: 1),
            child: myTextfield(
              controller: _passwordController,
              hintText: 'Password',
              obscure: vissible,
              icon: Icons.lock_outline,
              type: TextInputType.visiblePassword,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    if (vissible) {
                      vissible = false;
                    } else {
                      vissible = true;
                    }
                  });
                },
                child: Icon(
                  vissible
                      ? Icons.visibility_off_outlined
                      : Icons.remove_red_eye_outlined,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              const TextSpan(
                text: 'Need an account?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              const WidgetSpan(
                child: SizedBox(
                  width: 5,
                ),
              ),
              TextSpan(
                text: 'Register here',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    controller.animateToPage(1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
              ),
            ]),
          ),
          const SizedBox(height: 30),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              EasyLoading.dismiss();
              switch (state) {
                case AuthLoading():
                  EasyLoading.show(status: "Login in...");
                case Authenticated():
                  Navigator.pushNamedAndRemoveUntil(
                      context, homePageRoute, (route) => false);
                case Unauthenticated():
                  EasyLoading.showError(state.message.toTitleCase());
                default:
                  break;
              }
            },
            child: FadeIn(
              duration: const Duration(seconds: 1),
              child: SizedBox(
                height: 40,
                child: myButton(
                    onPressed: () {
                      final email = _emailController.text;
                      final password = _passwordController.text;

                      if (email.isNotEmpty || password.isNotEmpty) {
                        context
                            .read<AuthBloc>()
                            .add(LoginEvent(email: email, password: password));
                      }
                    },
                    text: 'Login'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
