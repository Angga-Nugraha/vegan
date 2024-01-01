import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/utils/routes.dart';
import '../../../data/utils/styles.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage')),
      body: Center(
        child: SizedBox(
          height: 40,
          width: 100,
          child: ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                switch (state) {
                  case Unauthenticated():
                    Navigator.pushReplacementNamed(context, authPageRoutes);
                  default:
                    break;
                }
              },
              builder: (context, state) {
                switch (state) {
                  case AuthLoading():
                    return const Center(
                        child:
                            CircularProgressIndicator(color: backgroundColor));
                  default:
                    return const Text(
                      'Logout',
                      style: TextStyle(fontSize: 20),
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
