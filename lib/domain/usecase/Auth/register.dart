import 'package:dartz/dartz.dart';
import 'package:vegan/domain/repositories/auth_repositories.dart';

import '../../../core/failure.dart';
import '../../entities/user.dart';

class Register {
  final AuthRepository authRepository;

  const Register({required this.authRepository});

  Future<Either<Failure, String>> execute(User user) async {
    return await authRepository.register(user);
  }
}
