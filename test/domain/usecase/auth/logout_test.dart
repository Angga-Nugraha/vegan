import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/domain/usecase/Auth/logout.dart';

import '../../../test_helper.mocks.dart';

void main() {
  late Logout logout;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    logout = Logout(authRepository: mockAuthRepository);
  });

  test('should logout from auth repositories', () async {
    // arrange
    when(mockAuthRepository.logout())
        .thenAnswer((_) async => const Right("Logout success"));
    // act
    final result = await logout.execute();

    // assert
    expect(result, const Right("Logout success"));
  });
}
