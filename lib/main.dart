import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vegan/domain/entities/product.dart';
import 'package:vegan/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:vegan/presentation/bloc/upload_bloc/upload_bloc.dart';
import 'package:vegan/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:vegan/presentation/pages/Product/all_product_view.dart';
import 'package:vegan/presentation/pages/Product/detail_product.dart';
import 'package:vegan/presentation/pages/Product/search_product.dart';
import 'package:vegan/presentation/pages/Profile/widget/change_password.dart';
import 'package:vegan/presentation/pages/Profile/widget/shipping_address.dart';
import 'package:vegan/presentation/pages/Profile/widget/user_information.dart';
import 'package:vegan/presentation/pages/root_screen.dart';

import 'domain/entities/user.dart';
import 'injection.dart' as di;
import 'core/routes.dart';
import 'core/styles.dart';
import 'presentation/bloc/auth_bloc/auth_bloc.dart';
import 'presentation/pages/Auth/auth_page.dart';
import 'presentation/pages/Auth/widgets/login_page.dart';
import 'presentation/pages/Auth/widgets/register_page.dart';
import 'presentation/pages/splash_screen.dart';

Future<void> main() async {
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
        BlocProvider(create: (context) => di.locator<UploadBloc>()),
        BlocProvider(create: (context) => di.locator<SearchBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vegan',
        themeMode: ThemeMode.system,
        theme: lightTheme,
        darkTheme: darkTheme,
        initialRoute: splashScreenRoute,
        navigatorObservers: [routeObserver],
        builder: EasyLoading.init(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case splashScreenRoute:
              return MaterialPageRoute(
                builder: (_) => const Splash(),
              );
            case userInfoRoutes:
              User user = settings.arguments as User;
              return customRoute(context, page: UserInfo(user: user));
            case shippingAddressRoutes:
              User user = settings.arguments as User;
              return customRoute(
                context,
                page: ShippingAddress(user: user),
              );
            case detailProductRoutes:
              Product product = settings.arguments as Product;
              return customRoute(context,
                  page: DetailProduct(product: product));
            case productViewRoutes:
              String category = settings.arguments as String;
              return customRoute(
                context,
                page: ProductView(category: category),
              );
            case changePassRoutes:
              return customRoute(
                context,
                page: const ChangePassword(),
              );
            case searchPageRoutes:
              return customRoute(
                context,
                page: SearchProductPage(),
              );
            case homePageRoute:
              return customRoute(
                context,
                page: const RootScreen(),
              );
            case authPageRoutes:
              return customRoute(
                context,
                page: const AuthPage(listPage: [
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
