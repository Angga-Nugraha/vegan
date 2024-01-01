import 'package:dartz/dartz.dart';
import 'package:vegan/domain/repositories/auth_repositories.dart';

import '../../../data/utils/failure.dart';
import '../../entities/auth.dart';

class Login {
  final AuthRepository authRepository;

  const Login({required this.authRepository});

  Future<Either<Failure, Auth>> execute(String email, String password) async {
    return await authRepository.login(email, password);
  }
}
