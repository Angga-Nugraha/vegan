import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';

import '../../../data/utils/constant.dart';
import '../../../data/utils/routes.dart';
import '../../../data/utils/styles.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../components/components_helper.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case Authenticated():
            Navigator.pushReplacementNamed(context, homePageRoute);
          case Unauthenticated():
            mySnackbar(context, message: state.message);
          default:
            break;
        }
      },
      child: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          children: [
            SizedBox(
              height: 250,
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
            const SizedBox(height: 20),
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
            FadeIn(
              duration: const Duration(seconds: 1),
              child: SizedBox(
                height: 40,
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    switch (state) {
                      case AuthLoading():
                        return const Center(
                          child: CircularProgressIndicator(
                            color: secondaryColor,
                          ),
                        );
                      default:
                        return ElevatedButton(
                          onPressed: () {
                            final email = _emailController.text;
                            final password = _passwordController.text;

                            if (email.isNotEmpty || password.isNotEmpty) {
                              context.read<AuthBloc>().add(
                                  LoginEvent(email: email, password: password));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: foregroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white,fontSize: 20),
                          ),
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
