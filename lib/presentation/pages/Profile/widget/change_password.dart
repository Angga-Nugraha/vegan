import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vegan/data/utils/constant.dart';
import 'package:vegan/data/utils/styles.dart';
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
              padding: const EdgeInsets.only(top: 10.0),
              color: foregroundColor,
              child: ListTile(
                minVerticalPadding: 10.0,
                minLeadingWidth: 0,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  'Change Password',
                  textAlign: TextAlign.center,
                  style: titleStyle.copyWith(color: backgroundColor),
                ),
              )),
          Positioned(
            top: 70,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  SizedBox(
                    height: 180,
                    child: Lottie.asset(
                      'assets/lottie/password.json',
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInLeft(
                    duration: const Duration(milliseconds: 500),
                    child: myTextfield(
                      controller: _currentPassController,
                      hintText: 'Current Password',
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
                      controller: _newPassController,
                      hintText: 'New Password',
                      icon: Icons.lock_reset_rounded,
                      obscure: vissible,
                      type: TextInputType.visiblePassword,
                    ),
                  ),
                  const SizedBox(height: 10),
                  isMatch == true
                      ? const SizedBox()
                      : Text(
                          'Confirm password doesn\'t match',
                          style: bodyTextStyle.copyWith(color: Colors.red),
                        ),
                  const SizedBox(height: 10),
                  FadeInLeft(
                    duration: const Duration(milliseconds: 500),
                    child: myTextfield(
                      controller: _confPassController,
                      obscure: vissible,
                      hintText: 'Confirm Password',
                      icon: Icons.lock_open_rounded,
                      type: TextInputType.visiblePassword,
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<UserBloc, UserState>(
                    listener: (context, state) {
                      switch (state) {
                        case UserUpdated():
                          mySnackbar(context,
                              message: state.message.toTitleCase());
                          context
                              .read<UserBloc>()
                              .add(const FetchCurrentUser());
                        case UserError():
                          mySnackbar(context,
                              message: state.message.toTitleCase());
                          context
                              .read<UserBloc>()
                              .add(const FetchCurrentUser());
                        default:
                          break;
                      }
                    },
                    builder: (context, state) {
                      if (state is UserLoading) {
                        isMatch = true;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return FadeIn(
                        duration: const Duration(milliseconds: 1000),
                        child: myButton(
                            onPressed: () {
                              if (_newPassController.text ==
                                  _confPassController.text) {
                                context.read<UserBloc>().add(ChangePassEvent(
                                    currentPassword:
                                        _currentPassController.text,
                                    newPassword: _newPassController.text));
                              } else {
                                setState(() {
                                  isMatch = false;
                                });
                              }
                            },
                            text: 'Save'),
                      );
                    },
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
