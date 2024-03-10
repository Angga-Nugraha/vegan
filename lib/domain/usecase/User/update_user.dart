import 'package:dartz/dartz.dart';
import 'package:vegan/core/failure.dart';
import 'package:vegan/domain/repositories/user_repository.dart';

import '../../entities/user.dart';

class UpdateUser {
  final UserRepository userRepository;

  const UpdateUser({required this.userRepository});

  Future<Either<Failure, User>> execute(User user) async {
    return await userRepository.updateUser(user);
  }
}
