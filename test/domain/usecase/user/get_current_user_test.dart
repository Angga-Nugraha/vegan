import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/domain/usecase/User/get_current_user.dart';

import '../../../dummy_data/object_dummy.dart';
import '../../../test_helper.mocks.dart';

void main(){
  late GetCurrentUser getCurrentUser;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    getCurrentUser = GetCurrentUser(userRepository: mockUserRepository);
  });  

  test('Should be return Right of User from User Repository', () async {
    // arrange
    when(mockUserRepository.getCurrentUser()).thenAnswer((_) async => Right(tUser));

    // act
    final result = await getCurrentUser.execute();

    // assert
    expect(result, equals(Right(tUser)));
  });
}