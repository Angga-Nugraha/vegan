import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:vegan/core/constant.dart';
import 'package:vegan/core/styles.dart';
import 'package:vegan/presentation/pages/components/components_helper.dart';

import '../../../bloc/user_bloc/user_bloc.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _currentPassController = TextEditingController();

  final TextEditingController _newPassController = TextEditingController();

  final TextEditingController _confPassController = TextEditingController();
  bool vissible = true;
  bool isMatch = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 30.0),
            color: Theme.of(context).colorScheme.primary,
            child: ListTile(
              minVerticalPadding: 10.0,
              minLeadingWidth: 0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: backgroundColor,
                ),
              ),
              title: Text(
                'Change Password',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30.0)),
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Lottie.asset(
                    height: 200,
                    'assets/lottie/password.json',
                  ),
                  const SizedBox(height: 20),
                  isMatch == true
                      ? const SizedBox()
                      : Text(
                          'Password & Confirm password doesn\'t match',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.red),
                        ),
                  const SizedBox(height: 20),
                  FadeInLeft(
                    duration: const Duration(milliseconds: 500),
                    child: myTextfield(
                      context,
                      controller: _currentPassController,
                      label: "Current Password",
                      obscure: vissible,
                      icon: Icons.lock_open_rounded,
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
                    duration: const Duration(milliseconds: 500),
                    child: myTextfield(
                      context,
                      label: "New Password",
                      controller: _newPassController,
                      icon: Icons.lock_reset_rounded,
                      obscure: vissible,
                      type: TextInputType.visiblePassword,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInLeft(
                    duration: const Duration(milliseconds: 500),
                    child: myTextfield(
                      context,
                      label: "Confirm Password",
                      controller: _confPassController,
                      obscure: vissible,
                      icon: Icons.lock_open_rounded,
                      type: TextInputType.visiblePassword,
                    ),
                  ),
                  const SizedBox(height: 30),
                  BlocListener<UserBloc, UserState>(
                    listener: (context, state) {
                      EasyLoading.dismiss();
                      setState(() {
                        isMatch = true;
                      });
                      switch (state) {
                        case UserLoading():
                          EasyLoading.show(status: "Saving...");
                        case UserUpdated():
                          EasyLoading.showSuccess(state.message.toTitleCase());
                          Future.delayed(
                              const Duration(seconds: 3),
                              () => context
                                  .read<UserBloc>()
                                  .add(const FetchCurrentUser()));
                        case UserError():
                          EasyLoading.showError(state.message.toTitleCase(),
                              duration: const Duration(seconds: 3));
                          Future.delayed(
                              const Duration(seconds: 3),
                              () => context
                                  .read<UserBloc>()
                                  .add(const FetchCurrentUser()));
                        default:
                          break;
                      }
                    },
                    child: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: UnconstrainedBox(
                        child: myButton(context, onPressed: () {
                          if (_newPassController.text ==
                              _confPassController.text) {
                            context.read<UserBloc>().add(ChangePassEvent(
                                currentPassword: _currentPassController.text,
                                newPassword: _newPassController.text));
                          } else {
                            setState(() {
                              isMatch = false;
                            });
                          }
                        }, text: 'Save'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
