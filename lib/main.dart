import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:vegan/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:vegan/presentation/pages/root_screen.dart';

import 'injection.dart' as di;
import 'data/utils/routes.dart';
import 'data/utils/styles.dart';
import 'presentation/bloc/auth_bloc/auth_bloc.dart';
import 'presentation/pages/Auth/auth_page.dart';
import 'presentation/pages/Auth/login_page.dart';
import 'presentation/pages/Auth/register_page.dart';
import 'presentation/pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<AuthBloc>()),
        BlocProvider(create: (context) => di.locator<ProductBloc>()),
        BlocProvider(create: (context) => di.locator<UserBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vegan',
        theme: myTheme,
        initialRoute: splashScreenRoute,
        navigatorObservers: [routeObserver],
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case splashScreenRoute:
              return MaterialPageRoute(
                builder: (_) => const Splash(),
              );
            case homePageRoute:
              return MaterialPageRoute(
                builder: (_) => const RootScreen(),
              );
            case authPageRoutes:
              return MaterialPageRoute(
                builder: (_) => const AuthPage(listPage: [
                  LoginPage(),
                  RegisterPage(),
                ]),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => const Splash(),
              );
          }
        },
      ),
    );
  }
}
