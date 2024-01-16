import 'package:dartz/dartz.dart';

import '../../data/utils/failure.dart';
import '../entities/user.dart';

abstract class UserRepository{
  Future<Either<Failure, User>> getCurrentUser();
}