import 'package:dartz/dartz.dart';
import 'package:vegan/domain/repositories/auth_repositories.dart';

import '../../../core/failure.dart';

class Logout {
  final AuthRepository authRepository;

  const Logout({required this.authRepository});

  Future<Either<Failure, String>> execute() async {
    return await authRepository.logout();
  }
}
