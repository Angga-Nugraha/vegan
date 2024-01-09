import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/domain/usecase/Auth/register.dart';

import '../../../dummy_data/object_dummy.dart';
import '../../../test_helper.mocks.dart';

void main() {
  late Register register;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    register = Register(authRepository: mockAuthRepository);
  });

  test('return register success from repositories if success', () async {
    when(mockAuthRepository.register(tUserRegister))
        .thenAnswer((_) async => const Right('register success'));

    final result = await register.execute(tUserRegister);

    expect(result, equals(const Right('register success')));
  });
}
