import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/data/repositories/auth_repositories_impl.dart';
import 'package:vegan/core/exception.dart';
import 'package:vegan/core/failure.dart';

import '../../dummy_data/object_dummy.dart';
import '../../test_helper.mocks.dart';

void main() {
  late AuthRepositoryImpl authRepositoryImpl;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepositoryImpl =
        AuthRepositoryImpl(authRemoteDataSource: mockAuthRemoteDataSource);
  });

  group('Authentication', () {
    test('should return status, id & token if login success', () async {
      // arrange
      when(mockAuthRemoteDataSource.login("email", "password"))
          .thenAnswer((_) async => tLoginModel);

      // act
      final result = await authRepositoryImpl.login("email", "password");

      // assert
      verify(mockAuthRemoteDataSource.login("email", "password"));
      expect(result, equals(const Right(tLogin)));
    });

    test('should return incorrect password if login failed', () async {
      // arrange
      when(mockAuthRemoteDataSource.login("email", "password"))
          .thenThrow(ServerException('incorrect password'));

      // act
      final result = await authRepositoryImpl.login("email", "password");

      // assert
      verify(mockAuthRemoteDataSource.login("email", "password"));
      expect(result, const Left(ServerFailure("incorrect password")));
    });
    test('should return user not found if login failed', () async {
      // arrange
      when(mockAuthRemoteDataSource.login("email", "password"))
          .thenThrow(ServerException('user not found'));

      // act
      final result = await authRepositoryImpl.login("email", "password");

      // assert
      verify(mockAuthRemoteDataSource.login("email", "password"));
      expect(result, const Left(ServerFailure("user not found")));
    });
    test('should return server exception if login failed', () async {
      // arrange
      when(mockAuthRemoteDataSource.login("email", "password"))
          .thenThrow(ServerException('Something went wrong'));

      // act
      final result = await authRepositoryImpl.login("email", "password");

      // assert
      verify(mockAuthRemoteDataSource.login("email", "password"));
      expect(result, const Left(ServerFailure("Something went wrong")));
    });

    test("should be register success if user register is approve ", () async {
      // arrange
      when(mockAuthRemoteDataSource.register(userModel))
          .thenAnswer((_) async => 'register success');
      // act
      final result = await authRepositoryImpl.register(tUserRegister);
      // assert
      verify(mockAuthRemoteDataSource.register(userModel));
      expect(result, const Right('register success'));
    });
  });
}
