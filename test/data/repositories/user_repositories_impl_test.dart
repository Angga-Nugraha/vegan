import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/data/repositories/user_repositories_impl.dart';

import '../../dummy_data/object_dummy.dart';
import '../../test_helper.mocks.dart';

void main() {
  late UserRepositoryImpl userRepositoryImpl;
  late MockUserRemoteDatasource mockUserRemoteDatasource;

  setUp(() {
    mockUserRemoteDatasource = MockUserRemoteDatasource();
    userRepositoryImpl =
        UserRepositoryImpl(userRemoteDatasource: mockUserRemoteDatasource);
  });

  group("User Repository", () {
    test('Return Right of User entity', () async {
      // arrange
      when(mockUserRemoteDatasource.getCurrentUser())
          .thenAnswer((_) async => tUserModel);
      // act
      final result = await userRepositoryImpl.getCurrentUser();

      // assert
      verify(mockUserRemoteDatasource.getCurrentUser());
      expect(result, equals(Right(tUser)));
    });
    test('Return Right of new User when update completed', () async {
      // arrange
      when(mockUserRemoteDatasource.updateUser(userModel))
          .thenAnswer((_) async => tUserModel);
      // act
      final result = await userRepositoryImpl.updateUser(tUserRegister);

      // assert
      verify(mockUserRemoteDatasource.updateUser(userModel));
      expect(result, equals(Right(tUser)));
    });
  });
}
