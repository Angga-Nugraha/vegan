import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:vegan/data/datasource/product_remote_datasource.dart';
import 'package:vegan/data/datasource/session_manager.dart';
import 'package:vegan/data/helpers/storage_helper.dart';
import 'package:vegan/data/repositories/product_repositories_impl.dart';
import 'package:vegan/domain/repositories/product_repositories.dart';
import 'package:vegan/domain/usecase/Product/get_product.dart';
import 'package:vegan/presentation/bloc/product_bloc/product_bloc.dart';

import 'data/datasource/auth_remote_datasource.dart';
import 'data/repositories/auth_repositories_impl.dart';
import 'domain/repositories/auth_repositories.dart';
import 'domain/usecase/Auth/login.dart';
import 'domain/usecase/Auth/logout.dart';
import 'domain/usecase/Auth/register.dart';
import 'presentation/bloc/auth_bloc/auth_bloc.dart';

final locator = GetIt.instance;

void init() {
  // BLOC
  locator.registerFactory(() => AuthBloc(
        login: locator(),
        logout: locator(),
        register: locator(),
      ));

  locator.registerFactory(
    () => ProductBloc(getAllProduct: locator()),
  );

  // USECASE
  locator.registerLazySingleton(() => Login(authRepository: locator()));
  locator.registerLazySingleton(() => Logout(authRepository: locator()));
  locator.registerLazySingleton(() => Register(authRepository: locator()));
  locator
      .registerLazySingleton(() => GetAllProduct(productRepository: locator()));

  // REPOSITORIES
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: locator()));
  locator.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productRemoteDatasource: locator()));

  // DATASOURCE
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
            client: locator(),
            session: locator(),
            storage: locator(),
          ));
  locator.registerLazySingleton<ProductRemoteDatasource>(
      () => ProductRemoteDatasourceImpl(
            client: locator(),
            storage: locator(),
          ));

  // HTTP
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => SecureStorageHelper());
  locator.registerLazySingleton(() => Session());
}
