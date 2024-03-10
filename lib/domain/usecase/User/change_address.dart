import 'package:dartz/dartz.dart';
import 'package:vegan/core/failure.dart';
import 'package:vegan/domain/repositories/user_repository.dart';

import '../../entities/user.dart';

class ChangeAddress {
  final UserRepository userRepository;

  const ChangeAddress({required this.userRepository});

  Future<Either<Failure, User>> execute(Address address) async {
    return await userRepository.changeAddress(address);
  }
}
