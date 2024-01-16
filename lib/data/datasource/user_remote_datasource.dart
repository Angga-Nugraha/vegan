import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vegan/data/helpers/storage_helper.dart';
import 'package:vegan/data/model/user_model.dart';
import 'package:vegan/data/utils/constant.dart';
import 'package:vegan/data/utils/exception.dart';

abstract class UserRemoteDatasource {
  Future<UserModel> getCurrentUser();
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final http.Client client;
  final SecureStorageHelper storage;

  UserRemoteDatasourceImpl({required this.client, required this.storage});

  @override
  Future<UserModel> getCurrentUser() async {
    final auth = await storage.readData('auth');
    Map<String, String> headers = {};
    String? userId;

    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      final data = json.decode(auth!);
      userId = data['id'];
      headers = {'authorization': 'Bearer ${data['accessToken']}'};
    } else {
      userId = '65a615e0ee0e998fa8b32068';
    }

    final response = await client.get(Uri.parse('$baseUrl/api/user/$userId'),
        headers: headers);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return UserModel.fromJson(data['data']);
    } else {
      throw ServerException(data['msg']);
    }
  }
}