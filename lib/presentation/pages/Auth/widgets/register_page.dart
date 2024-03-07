import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vegan/domain/entities/user.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../data/utils/constant.dart';
import '../../../../data/utils/styles.dart';
import '../../../bloc/auth_bloc/auth_bloc.dart';
import '../../components/components_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confPasswordController = TextEditingController();

  bool vissible = true;
  bool selected = false;

  Future<String> loadBundle(String name) async {
    return await rootBundle.loadString(name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case Registered():
            mySnackbar(context, message: state.message.toTitleCase());
            Future.delayed(const Duration(seconds: 2), () {
              controller.animateToPage(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut);
            });
          case Unregistered():
            mySnackbar(context,
                message: state.message.toTitleCase(), color: Colors.red);
          default:
            break;
        }
      },
      child: Center(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            SizedBox(
              height: 150,
              child: Lottie.asset(
                'assets/lottie/login.json',
              ),
            ),
            const SizedBox(height: 20),
            FadeIn(
              duration: const Duration(seconds: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Let\'s join with us...',
                    style: titleStyle,
                  ),
                  Text('Create your account', style: subTitleStyle),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FadeInRight(
              duration: const Duration(seconds: 1),
              child: myTextfield(
                controller: _nameController,
                hintText: 'Name',
                icon: Icons.person_2_outlined,
                type: TextInputType.name,
              ),
            ),
            const SizedBox(height: 20),
            FadeInLeft(
              duration: const Duration(seconds: 1),
              child: myTextfield(
                controller: _emailController,
                hintText: 'Email',
                icon: Icons.email_outlined,
                type: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 20),
            FadeInRight(
              duration: const Duration(seconds: 1),
              child: myTextfield(
                controller: _phoneController,
                hintText: 'Phone number',
                icon: Icons.phone_android_outlined,
                type: const TextInputType.numberWithOptions(signed: true),
              ),
            ),
            const SizedBox(height: 20),
            FadeInLeft(
              duration: const Duration(seconds: 1),
              child: myTextfield(
                controller: _passwordController,
                hintText: 'Password at least 8 character',
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
            FadeInRight(
              duration: const Duration(seconds: 1),
              child: myTextfield(
                controller: _confPasswordController,
                hintText: 'Confirm password',
                obscure: vissible,
                icon: Icons.lock_outline,
                type: TextInputType.visiblePassword,
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: selected,
                  activeColor: secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selected = value!;
                    });
                  },
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'I agree to the ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy & Policy',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Privacy & Policy'),
                                contentPadding: const EdgeInsets.all(20.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                content: FutureBuilder(
                                  future: loadBundle(
                                      'assets/doc/privacy_policy.txt'),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Column(
                                          children: [
                                            Text(
                                              snapshot.data!,
                                              style: bodyTextStyle,
                                              textAlign: TextAlign.justify,
                                            ),
                                            const SizedBox(height: 20.0),
                                            OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                    minimumSize:
                                                        const Size(150, 30)),
                                                onPressed: () {
                                                  setState(() {
                                                    selected = true;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('I agree'))
                                          ],
                                        ),
                                      );
                                    } else {
                                      return const Text('');
                                    }
                                  },
                                ),
                              );
                            },
                          );
                        },
                    ),
                  ]),
                ),
              ],
            ),
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
                        return myButton(
                            onPressed: !selected
                                ? null
                                : () {
                                    final name = _nameController.text;
                                    final email = _emailController.text;
                                    final phone = _phoneController.text;
                                    final password = _passwordController.text;
                                    final confPassword =
                                        _confPasswordController.text;

                                    if (email.isNotEmpty ||
                                        password.isNotEmpty ||
                                        name.isNotEmpty ||
                                        phone.isNotEmpty) {
                                      context.read<AuthBloc>().add(
                                            RegisterEvent(
                                              user: User(
                                                name: name,
                                                email: email,
                                                phone: phone,
                                                password: password,
                                                confPassword: confPassword,
                                              ),
                                            ),
                                          );
                                    }
                                  },
                            text: 'Register');
                      // ElevatedButton(
                      //   onPressed: !selected
                      //       ? null
                      //       : () {
                      //           final name = _nameController.text;
                      //           final email = _emailController.text;
                      //           final phone = _phoneController.text;
                      //           final password = _passwordController.text;
                      //           final confPassword =
                      //               _confPasswordController.text;
                      //           final address = _addressController.text;

                      //           if (email.isNotEmpty ||
                      //               password.isNotEmpty ||
                      //               name.isNotEmpty ||
                      //               phone.isNotEmpty) {
                      //             context.read<AuthBloc>().add(
                      //                   RegisterEvent(
                      //                     user: User(
                      //                         name: name,
                      //                         email: email,
                      //                         phone: phone,
                      //                         password: password,
                      //                         confPassword: confPassword,
                      //                         address: address),
                      //                   ),
                      //                 );
                      //           }
                      //         },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: foregroundColor,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //   ),
                      //   child: const Text(
                      //     'Register',
                      //     style: TextStyle(color: Colors.white, fontSize: 20),
                      //   ),
                      // );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                const TextSpan(
                  text: 'Already account?',
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
                  text: 'Login here',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      controller.animateToPage(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut);
                    },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
