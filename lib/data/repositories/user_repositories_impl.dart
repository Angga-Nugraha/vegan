import 'package:dartz/dartz.dart';
import 'package:vegan/data/datasource/user_remote_datasource.dart';
import 'package:vegan/data/utils/exception.dart';
import 'package:vegan/data/utils/failure.dart';
import 'package:vegan/domain/entities/user.dart';
import 'package:vegan/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource userRemoteDatasource;

  const UserRepositoryImpl({required this.userRemoteDatasource});
  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final result = await userRemoteDatasource.getCurrentUser();

      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}