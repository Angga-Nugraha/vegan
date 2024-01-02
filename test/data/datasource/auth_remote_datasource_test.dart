import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:vegan/data/datasource/auth_remote_datasource.dart';
import 'package:vegan/data/datasource/session_manager.dart';
import 'package:vegan/data/utils/constant.dart';
import 'package:vegan/data/utils/exception.dart';

import '../../dummy_data/object_dummy.dart';
import '../../read_json.dart';
import '../../test_helper.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthRemoteDataSourceImpl dataSourceImpl;
  late Session session;
  late MockHttpClient mockHttpClient;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    mockHttpClient = MockHttpClient();
    dataSourceImpl = AuthRemoteDataSourceImpl(mockHttpClient);
    session = Session();
  });

  group("Login", () {
    test('should be login if user login success', () async {
      // arrange
      when(
        mockHttpClient.post(Uri.parse('$baseUrl/Auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({"email": "email", "password": "password"})),
      ).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/login.json'), 200));

      // act
      final result = await dataSourceImpl.login("email", "password");

      // assert
      expect(result, equals(tLoginModel));
    });
    test('should be return message error if response status code 400',
        () async {
      // arrange
      when(
        mockHttpClient.post(Uri.parse('$baseUrl/Auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({"email": "email", "password": "password"})),
      ).thenThrow(ServerException('message error'));

      // act
      final result = dataSourceImpl.login("email", "password");

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });

    test('should be throw server exception if server error', () async {
      // arrange
      when(
        mockHttpClient.post(Uri.parse('$baseUrl/Auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({"email": "email", "password": "password"})),
      ).thenThrow(ServerException('Something went wrong'));

      // act
      final result = dataSourceImpl.login("email", "password");

      // assert
      expect(() => result, throwsA(isA<ServerException>()));
    });
  });
  group('Logout', () {
    test('should be return Logout success if user logout success', () async {
      // arrange

      when(
        mockHttpClient.delete(Uri.parse('$baseUrl/Auth/logout'),
            headers: session.headers),
      ).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/logout.json'), 200));

      // act
      final result = await dataSourceImpl.logout();

      // assert
      expect(result, equals("Logout success"));
    });
    test('should be no content if server error', () async {
      // arrange
      when(
        mockHttpClient.delete(Uri.parse('$baseUrl/Auth/logout'),
            headers: session.headers),
      ).thenThrow(ServerException('Something went wrong'));

      // act
      final result = dataSourceImpl.logout();

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
  group('Register', () {
    test('should be register success if user register is success', () async {
      when(
        mockHttpClient.post(Uri.parse('$baseUrl/Auth/register'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(tUserRegisterModel.toJson())),
      ).thenAnswer((_) async =>
          http.Response(readJson('dummy_data/register.json'), 200));

      // act
      final result = await dataSourceImpl.register(tUserRegister);

      // assert
      expect(result, equals('register success'));
    });
    test('should be error message if user register is failed', () async {
      when(
        mockHttpClient.post(Uri.parse('$baseUrl/Auth/register'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(tUserRegisterModel.toJson())),
      ).thenAnswer((_) async =>
          http.Response(readJson('dummy_data/response_failed.json'), 400));

      // act
      final result = dataSourceImpl.register(tUserRegister);

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
    test('should be throw server exception if server error', () async {
      when(
        mockHttpClient.post(Uri.parse('$baseUrl/Auth/register'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(tUserRegisterModel.toJson())),
      ).thenThrow(ServerException('Something went wrong'));

      // act
      final result = dataSourceImpl.register(tUserRegister);

      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
