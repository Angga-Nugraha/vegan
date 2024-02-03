import 'package:dartz/dartz.dart';
import 'package:vegan/data/utils/failure.dart';
import 'package:vegan/domain/repositories/user_repository.dart';

class ChangePassword {
  final UserRepository userRepository;

  const ChangePassword({required this.userRepository});

  Future<Either<Failure, String>> execute(
      String currentPassword, String newPassword) async {
    return await userRepository.changePassword(currentPassword, newPassword);
  }
}
