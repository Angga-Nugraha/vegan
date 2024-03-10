import 'package:dartz/dartz.dart';
import 'package:vegan/data/datasource/user_remote_datasource.dart';
import 'package:vegan/data/model/user_model.dart';
import 'package:vegan/core/exception.dart';
import 'package:vegan/core/failure.dart';
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

  @override
  Future<Either<Failure, User>> updateUser(User user) async {
    final userModel = UserModel.fromEntity(user);

    try {
      final result = await userRemoteDatasource.updateUser(userModel);

      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> changePassword(
      String currentPassword, String newPassword) async {
    try {
      final result = await userRemoteDatasource.changePassword(
          currentPassword, newPassword);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> changeAddress(Address address) async {
    try {
      final addressModel = AddressModel.fromEntity(address);
      final result = await userRemoteDatasource.changeAddress(addressModel);

      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
