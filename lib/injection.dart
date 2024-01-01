import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasource/auth_remote_datasource.dart';
import 'data/repositories/auth_repositories_impl.dart';
import 'domain/repositories/auth_repositories.dart';
import 'domain/usecase/Auth/login.dart';
import 'domain/usecase/Auth/logout.dart';
import 'presentation/bloc/auth_bloc/auth_bloc.dart';

final locator = GetIt.instance;

void init() {
  // BLOC
  locator.registerFactory(() => AuthBloc(login: locator(), logout: locator()));

  // USECASE
  locator.registerLazySingleton(() => Login(authRepository: locator()));
  locator.registerLazySingleton(() => Logout(authRepository: locator()));

  // REPOSITORIES
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: locator()));

  // DATASOURCE
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(locator()));

  // HTTP
  locator.registerLazySingleton(() => http.Client());
}
