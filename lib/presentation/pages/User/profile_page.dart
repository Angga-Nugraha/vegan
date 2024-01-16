import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan/data/utils/constant.dart';
import 'package:vegan/data/utils/routes.dart';
import 'package:vegan/data/utils/styles.dart';
import 'package:vegan/domain/entities/user.dart';
import 'package:vegan/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:vegan/presentation/bloc/user_bloc/user_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthLoading():
            break;
          case LogoutError():
            debugPrint('Error');
            Navigator.pushReplacementNamed(context, authPageRoutes);
          case Unauthenticated():
            Navigator.pushReplacementNamed(context, authPageRoutes);
          default:
            Navigator.pushReplacementNamed(context, authPageRoutes);
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
              top: 40,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                },
                child: const Icon(
                  Icons.logout_rounded,
                  color: backgroundColor,
                ),
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
                              final user = state.result;
                              return _builUserHeader(user);
                            case UserError():
                              return Text(state.message);
                            default:
                              return const SizedBox();
                          }
                        },
                      ),
                    ),
                    const Divider(),
                    _buildSubMenu(
                        icon: Icons.person, title: 'Acount Information'),
                    _buildSubMenu(
                        icon: Icons.location_on_outlined,
                        title: 'Delivery Adrress'),
                    _buildSubMenu(
                        icon: Icons.payment_outlined, title: 'Payment Method'),
                    _buildSubMenu(
                        icon: Icons.lock_outlined, title: 'Changed Password'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubMenu({required IconData icon, required String title}) {
    return ListTile(
      iconColor: foregroundColor,
      titleTextStyle: subTitleStyle.copyWith(color: Colors.black87),
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }

  Widget _builUserHeader(User user) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                image: DecorationImage(
                  image: user.image == null
                      ? const AssetImage('assets/img/no_profile.jpg')
                      : NetworkImage(convertUrl(user.image!)) as ImageProvider,
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
            GestureDetector(
              child: const Icon(
                Icons.add_a_photo_rounded,
                color: Colors.black87,
                size: 24,
              ),
            )
          ],
        ),
        Text(
          user.name.toTitleCase(),
          style: subTitleStyle.copyWith(color: Colors.black87),
        ),
        Text(
          user.email.toTitleCase(),
          style: bodyTextStyle,
        ),
      ],
    );
  }
}
