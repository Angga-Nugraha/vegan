import 'package:dartz/dartz.dart';
import 'package:vegan/domain/entities/auth.dart';

import '../../data/utils/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, Auth>> login(String email, String password);
  Future<Either<Failure, String>> logout();
}
