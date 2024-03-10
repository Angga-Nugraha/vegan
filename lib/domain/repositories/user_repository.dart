import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, User>> updateUser(User user);
  Future<Either<Failure, User>> changeAddress(Address address);
  Future<Either<Failure, String>> changePassword(
      String currentPassword, String newPassword);
}
