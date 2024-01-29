import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/domain/usecase/User/update_user.dart';

import '../../../dummy_data/object_dummy.dart';
import '../../../test_helper.mocks.dart';

void main() {
  late UpdateUser updateUser;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    updateUser = UpdateUser(userRepository: mockUserRepository);
  });

  test(
      'Should be return Right of new User from User Repository if update completed',
      () async {
    // arrange
    when(mockUserRepository.updateUser(tUserRegister))
        .thenAnswer((_) async => Right(tUser));

    // act
    final result = await updateUser.execute(tUserRegister);

    // assert
    expect(result, equals(Right(tUser)));
  });
}
