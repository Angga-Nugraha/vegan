import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:vegan/data/datasource/user_remote_datasource.dart';
import 'package:vegan/data/helpers/storage_helper.dart';
import 'package:vegan/data/utils/constant.dart';
import 'package:vegan/data/utils/exception.dart';

import '../../dummy_data/object_dummy.dart';
import '../../read_json.dart';
import '../../test_helper.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late UserRemoteDatasourceImpl dataSourceImpl;
  late SecureStorageHelper storage;
  late MockHttpClient mockHttpClient;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    mockHttpClient = MockHttpClient();
    storage = SecureStorageHelper();
    dataSourceImpl = UserRemoteDatasourceImpl(
      client: mockHttpClient,
      storage: storage,
    );
  });

  const userId = '65a615e0ee0e998fa8b32068';
  group('User', () {
    test('Get User by id', () async {
      when(mockHttpClient
          .get(Uri.parse('$baseUrl/api/user/$userId'),
              headers: {})).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/user.json'), 200));

      final result = await dataSourceImpl.getCurrentUser();

      expect(result, equals(tUserModel));
    });

    test('Throw exception Get User by id failed', () async {
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/api/user/$userId'), headers: {}))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/response_failed.json'), 404));

      final result = dataSourceImpl.getCurrentUser();

      expect(result, throwsA(isA<ServerException>()));
    });

    test('Update user', () async {
      when(mockHttpClient.patch(Uri.parse('$baseUrl/api/user/$userId'),
              headers: {}, body: json.encode(userModel.toJson())))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/user.json'), 200));

      final result = await dataSourceImpl.updateUser(userModel);

      expect(result, equals(tUserModel));
    });
    test('throw server exception when Update user failed', () async {
      when(mockHttpClient.patch(Uri.parse('$baseUrl/api/user/$userId'),
              headers: {}, body: json.encode(userModel.toJson())))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/response_failed.json'), 404));

      final result = dataSourceImpl.updateUser(userModel);

      expect(result, throwsA(isA<ServerException>()));
    });
    test('show password change when status code 200', () async {
      when(mockHttpClient.patch(
        Uri.parse('$baseUrl/api/user/change-password/$userId'),
        headers: {},
        body: json.encode({
          "currentPassword": "curentPass",
          "newPassword": "newPass",
        }),
      )).thenAnswer((_) async =>
          http.Response(readJson('dummy_data/change_pass.json'), 200));

      final result =
          await dataSourceImpl.changePassword("curentPass", "newPass");

      expect(result, equals("password changed"));
    });
    test('show message error when status code 400', () async {
      when(mockHttpClient.patch(
        Uri.parse('$baseUrl/api/user/change-password/$userId'),
        headers: {},
        body: json.encode({
          "currentPassword": "curentPass",
          "newPassword": "newPass",
        }),
      )).thenAnswer((_) async =>
          http.Response(readJson('dummy_data/response_failed.json'), 404));

      final result = dataSourceImpl.changePassword("curentPass", "newPass");

      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
