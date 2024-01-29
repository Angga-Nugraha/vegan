import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan/data/utils/constant.dart';
import 'package:vegan/data/utils/routes.dart';
import 'package:vegan/data/utils/styles.dart';
import 'package:vegan/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:vegan/presentation/bloc/user_bloc/user_bloc.dart';

import '../../../domain/entities/user.dart';
import '../../bloc/upload_bloc/upload_bloc.dart';
import '../components/components_helper.dart';
import 'widget/user_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static User? user;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadBloc, UploadState>(
      listener: (context, state) {
        switch (state) {
          case UploadSuccess():
            mySnackbar(context, message: state.message.toTitleCase());
          case UploadError():
            mySnackbar(context, message: state.message);
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
              color: foregroundColor,
              child: Text(
                'Profile',
                textAlign: TextAlign.center,
                style: titleStyle.copyWith(color: backgroundColor),
              ),
            ),
            Positioned(
              top: 70,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  color: backgroundColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30.0)),
                ),
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  physics: const ClampingScrollPhysics(),
                  children: [
                    SizedBox(
                      child: BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          switch (state) {
                            case UserLoading():
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case UserLoaded():
                              user = state.result;
                              return FadeIn(
                                  duration: const Duration(milliseconds: 500),
                                  child: UserHeader(user: user!));
                            case UserError():
                              return Text(state.message);
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
                            Navigator.pushNamed(context, userInfoRoutes);
                          },
                          icon: Icons.person,
                          title: 'Acount Information'),
                    ),
                    FadeInRight(
                      duration: const Duration(milliseconds: 500),
                      child: _buildSubMenu(
                          onTap: () {},
                          icon: Icons.payment_outlined,
                          title: 'Payment Method'),
                    ),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 500),
                      child: _buildSubMenu(
                          onTap: () {},
                          icon: Icons.lock_outlined,
                          title: 'Changed Password'),
                    ),
                    FadeInRight(
                      duration: const Duration(milliseconds: 500),
                      child: _buildSubMenu(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                titleTextStyle: subTitleStyle,
                                contentTextStyle: bodyTextStyle,
                                title: const Text(
                                  'Logout',
                                ),
                                content: BlocConsumer<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    switch (state) {
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
                                  builder: (context, state) {
                                    switch (state) {
                                      case AuthLoading():
                                        return const SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      default:
                                        return const Text(
                                          'Are you sure want to logout?',
                                        );
                                    }
                                  },
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'No',
                                      style:
                                          subTitleStyle.copyWith(fontSize: 12),
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
                                      style:
                                          subTitleStyle.copyWith(fontSize: 12),
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
      iconColor: foregroundColor,
      titleTextStyle: subTitleStyle.copyWith(color: Colors.black87),
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
