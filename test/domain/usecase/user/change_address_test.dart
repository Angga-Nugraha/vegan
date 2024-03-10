import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/domain/usecase/User/change_address.dart';

import '../../../dummy_data/object_dummy.dart';
import '../../../test_helper.mocks.dart';

void main() {
  late ChangeAddress changeAddress;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    changeAddress = ChangeAddress(userRepository: mockUserRepository);
  });

  test(
      'Should be return Right of new User from User Repository if update address completed',
      () async {
    // arrange
    when(mockUserRepository.changeAddress(address))
        .thenAnswer((_) async => Right(tUser));

    // act
    final result = await changeAddress.execute(address);

    // assert
    expect(result, equals(Right(tUser)));
  });
}
