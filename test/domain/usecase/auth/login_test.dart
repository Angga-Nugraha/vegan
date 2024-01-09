import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/domain/usecase/Auth/login.dart';

import '../../../dummy_data/object_dummy.dart';
import '../../../test_helper.mocks.dart';

void main() {
  late Login login;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    login = Login(authRepository: mockAuthRepository);
  });

  test('should login from auth repositories', () async {
    // arrange
    when(mockAuthRepository.login("email", "password"))
        .thenAnswer((_) async => const Right(tLogin));
    // act
    final result = await login.execute("email", "password");

    // assert
    expect(result, const Right(tLogin));
  });
}
