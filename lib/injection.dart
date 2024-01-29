import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:vegan/data/datasource/product_remote_datasource.dart';
import 'package:vegan/data/datasource/session_manager.dart';
import 'package:vegan/data/datasource/upload.dart';
import 'package:vegan/data/datasource/user_remote_datasource.dart';
import 'package:vegan/data/helpers/storage_helper.dart';
import 'package:vegan/data/repositories/product_repositories_impl.dart';
import 'package:vegan/data/repositories/user_repositories_impl.dart';
import 'package:vegan/domain/entities/upload.dart';
import 'package:vegan/domain/repositories/product_repositories.dart';
import 'package:vegan/domain/repositories/user_repository.dart';
import 'package:vegan/domain/usecase/Product/get_product.dart';
import 'package:vegan/domain/usecase/User/get_current_user.dart';
import 'package:vegan/domain/usecase/User/update_user.dart';
import 'package:vegan/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:vegan/presentation/bloc/upload_bloc/upload_bloc.dart';
import 'package:vegan/presentation/bloc/user_bloc/user_bloc.dart';

import 'data/datasource/auth_remote_datasource.dart';
import 'data/repositories/auth_repositories_impl.dart';
import 'data/repositories/upload_repositories_impl.dart';
import 'domain/repositories/auth_repositories.dart';
import 'domain/repositories/upload_repositories.dart';
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

  locator.registerFactory(
    () => UserBloc(getCurrentUser: locator(), updateUser: locator()),
  );

  locator.registerFactory(
    () => UploadBloc(upload: locator()),
  );

  // USECASE
  // auth
  locator.registerLazySingleton(() => Login(authRepository: locator()));
  locator.registerLazySingleton(() => Logout(authRepository: locator()));
  locator.registerLazySingleton(() => Register(authRepository: locator()));

  // product
  locator
      .registerLazySingleton(() => GetAllProduct(productRepository: locator()));

  // user
  locator
      .registerLazySingleton(() => GetCurrentUser(userRepository: locator()));
  locator.registerLazySingleton(() => UpdateUser(userRepository: locator()));

  // upload
  locator.registerLazySingleton(() => Upload(uploadRepository: locator()));

  // REPOSITORIES
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: locator()));
  locator.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(productRemoteDatasource: locator()));
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userRemoteDatasource: locator()),
  );
  locator.registerLazySingleton<UploadRepository>(
    () => UploadRepositoryImpl(uploadImage: locator()),
  );

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
  locator.registerLazySingleton<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(
            client: locator(),
            storage: locator(),
          ));
  locator.registerLazySingleton<UploadImage>(() => UploadImageImpl(
        storage: locator(),
      ));

  // HTTP
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => SecureStorageHelper());
  locator.registerLazySingleton(() => Session());
}
