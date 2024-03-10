import 'package:dartz/dartz.dart';
import 'package:vegan/data/datasource/auth_remote_datasource.dart';
import 'package:vegan/core/exception.dart';
import 'package:vegan/core/failure.dart';
import 'package:vegan/domain/entities/auth.dart';
import 'package:vegan/domain/entities/user.dart';
import 'package:vegan/domain/repositories/auth_repositories.dart';

import '../model/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, Auth>> login(String email, String password) async {
    try {
      final result = await authRemoteDataSource.login(email, password);

      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      final result = await authRemoteDataSource.logout();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> register(User user) async {
    final userModel = UserModel.fromEntity(user);
    try {
      final result = await authRemoteDataSource.register(userModel);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
