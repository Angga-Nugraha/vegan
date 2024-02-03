import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/domain/usecase/User/change_password.dart';

import '../../../test_helper.mocks.dart';

void main() {
  late ChangePassword changePassword;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    changePassword = ChangePassword(userRepository: mockUserRepository);
  });

  test('Should be return Right of message if completed', () async {
    // arrange
    when(mockUserRepository.changePassword("currentPassword", "newPassword"))
        .thenAnswer((_) async => const Right("password changed"));

    // act
    final result =
        await changePassword.execute("currentPassword", "newPassword");

    // assert
    expect(result, equals(const Right("password changed")));
  });
}
