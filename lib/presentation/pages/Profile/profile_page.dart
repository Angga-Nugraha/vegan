import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vegan/core/constant.dart';
import 'package:vegan/core/routes.dart';
import 'package:vegan/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:vegan/presentation/bloc/user_bloc/user_bloc.dart';

import '../../../domain/entities/user.dart';
import '../../bloc/upload_bloc/upload_bloc.dart';
import 'widget/user_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static User? user;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadBloc, UploadState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        switch (state) {
          case UploadLoading():
            EasyLoading.show(status: "Uploading...");
          case UploadSuccess():
            EasyLoading.showToast(state.message.toTitleCase());
          case UploadError():
            EasyLoading.showToast(state.message.toTitleCase());
          default:
            break;
        }
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 30.0),
              color: Theme.of(context).colorScheme.primary,
              child: Text(
                'Profile',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            Positioned(
              top: 80,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30.0)),
                ),
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  physics: const ClampingScrollPhysics(),
                  children: [
                    SizedBox(
                      child: BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          switch (state) {
                            case UserLoaded():
                              user = state.result;
                              return FadeIn(
                                  duration: const Duration(milliseconds: 500),
                                  child: UserHeader(user: user!));
                            default:
                              return const SizedBox();
                          }
                        },
                      ),
                    ),
                    const Divider(),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      child: _buildSubMenu(
                          onTap: () {
                            Navigator.pushNamed(context, userInfoRoutes,
                                arguments: user);
                          },
                          icon: Icons.person,
                          title: 'Acount Information'),
                    ),
                    FadeInRight(
                      duration: const Duration(milliseconds: 500),
                      child: _buildSubMenu(
                          onTap: () {
                            Navigator.pushNamed(context, shippingAddressRoutes,
                                arguments: user);
                          },
                          icon: Icons.location_city_rounded,
                          title: 'Shipping Address'),
                    ),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      child: _buildSubMenu(
                          onTap: () {},
                          icon: Icons.payment_outlined,
                          title: 'Payment Method'),
                    ),
                    FadeInRight(
                      duration: const Duration(milliseconds: 500),
                      child: _buildSubMenu(
                          onTap: () {
                            Navigator.pushNamed(context, changePassRoutes);
                          },
                          icon: Icons.lock_outlined,
                          title: 'Changed Password'),
                    ),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      child: _buildSubMenu(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                titleTextStyle:
                                    Theme.of(context).textTheme.titleMedium,
                                contentTextStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                                title: const Text(
                                  'Logout',
                                ),
                                content: BlocListener<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    EasyLoading.dismiss();
                                    switch (state) {
                                      case AuthLoading():
                                        EasyLoading.show(status: "Logout...");
                                      case Unauthenticated():
                                        Navigator.pushReplacementNamed(
                                            context, authPageRoutes);
                                      case LogoutError():
                                        Navigator.pushReplacementNamed(
                                            context, authPageRoutes);
                                      default:
                                        Navigator.pushReplacementNamed(
                                            context, authPageRoutes);
                                    }
                                  },
                                  child: const Text(
                                    'Are you sure want to logout?',
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'No',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<AuthBloc>()
                                          .add(LogoutEvent());
                                    },
                                    child: Text(
                                      'Yes',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icons.logout_rounded,
                          title: 'Logout'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubMenu({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Text(title),
      trailing: const Icon(
        Icons.keyboard_arrow_right_outlined,
        size: 20,
      ),
    );
  }
}
