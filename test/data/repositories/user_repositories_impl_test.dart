import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/data/repositories/user_repositories_impl.dart';
import 'package:vegan/core/exception.dart';
import 'package:vegan/core/failure.dart';

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
    test('Return Left of message', () async {
      // arrange
      when(mockUserRemoteDatasource.getCurrentUser())
          .thenThrow(ServerException("message"));
      // act
      final result = await userRepositoryImpl.getCurrentUser();

      // assert
      verify(mockUserRemoteDatasource.getCurrentUser());
      expect(result, const Left(ServerFailure("message")));
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
    test('Return Left message when update failed', () async {
      // arrange
      when(mockUserRemoteDatasource.updateUser(userModel))
          .thenThrow(ServerException("message"));
      // act
      final result = await userRepositoryImpl.updateUser(tUserRegister);

      // assert
      verify(mockUserRemoteDatasource.updateUser(userModel));
      expect(result, const Left(ServerFailure("message")));
    });
    test('Return Right of String when changePassword completed', () async {
      // arrange
      when(mockUserRemoteDatasource.changePassword(
              "currentPassword", "newPassword"))
          .thenAnswer((_) async => "password changed");
      // act
      final result = await userRepositoryImpl.changePassword(
          "currentPassword", "newPassword");

      // assert
      verify(mockUserRemoteDatasource.changePassword(
          "currentPassword", "newPassword"));
      expect(result, equals(const Right("password changed")));
    });
    test('Return Left of String when changePassword error', () async {
      // arrange
      when(mockUserRemoteDatasource.changePassword(
              "currentPassword", "newPassword"))
          .thenThrow(ServerException('message'));
      // act
      final result = await userRepositoryImpl.changePassword(
          "currentPassword", "newPassword");

      // assert
      verify(mockUserRemoteDatasource.changePassword(
          "currentPassword", "newPassword"));
      expect(result, const Left(ServerFailure("message")));
    });
    test('Return Left when changePassword error', () async {
      // arrange
      when(mockUserRemoteDatasource.changePassword(
              "currentPassword", "newPassword"))
          .thenThrow('message');
      // act
      final result = await userRepositoryImpl.changePassword(
          "currentPassword", "newPassword");

      // assert
      verify(mockUserRemoteDatasource.changePassword(
          "currentPassword", "newPassword"));
      expect(result, const Left(CommonFailure("message")));
    });

    test('Return Right of new User when update address completed', () async {
      // arrange
      when(mockUserRemoteDatasource.changeAddress(addressModel))
          .thenAnswer((_) async => tUserModel);
      // act
      final result = await userRepositoryImpl.changeAddress(address);

      // assert
      verify(mockUserRemoteDatasource.changeAddress(addressModel));
      expect(result, equals(Right(tUser)));
    });
    test('Return Left message when update failed', () async {
      // arrange
      when(mockUserRemoteDatasource.changeAddress(addressModel))
          .thenThrow(ServerException("message"));
      // act
      final result = await userRepositoryImpl.changeAddress(address);

      // assert
      verify(mockUserRemoteDatasource.changeAddress(addressModel));
      expect(result, const Left(ServerFailure("message")));
    });
  });
}
