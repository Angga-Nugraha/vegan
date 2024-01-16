import 'package:dartz/dartz.dart';
import 'package:vegan/data/utils/failure.dart';
import 'package:vegan/domain/repositories/user_repository.dart';

import '../../entities/user.dart';

class GetCurrentUser{
  final UserRepository userRepository;

  const GetCurrentUser({required this.userRepository});

  Future<Either<Failure, User>> execute() async {
    return await userRepository.getCurrentUser();
  }
}