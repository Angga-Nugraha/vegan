import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:vegan/data/datasource/session_manager.dart';
import 'package:vegan/data/helpers/storage_helper.dart';
import 'package:vegan/data/model/auth_model.dart';
import 'package:vegan/data/model/user_model.dart';
import 'package:vegan/core/exception.dart';

import '../../core/constant.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String email, String password);
  Future<String> logout();
  Future<String> register(UserModel user);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final Session session;
  final SecureStorageHelper storage;

  const AuthRemoteDataSourceImpl(
      {required this.client, required this.session, required this.storage});

  @override
  Future<AuthModel> login(String email, String password) async {
    final response = await client.post(Uri.parse('$baseUrl/Auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"email": email, "password": password}));

    await storage.writeData('auth', response.body);

    final Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));

    if (response.statusCode == 200) {
      await session.updateCookie(response);
      return AuthModel.fromJson(data);
    } else {
      throw ServerException(data['msg']);
    }
  }

  @override
  Future<String> logout() async {
    final cookie = await storage.readData('cookie');
    Map<String, String> headers = {};
    //only runs when you are NOT testing
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      final String token = json.decode(cookie!)["Cookie"];
      headers = {'Cookie': token};
    }

    final response = await client.delete(Uri.parse('$baseUrl/Auth/logout'),
        headers: session.headers.isEmpty ? headers : session.headers);

    final Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));
    await storage.deleteSecureStorage();
    if (response.statusCode == 200) {
      return data['msg'];
    } else {
      throw ServerException('Something went wrong');
    }
  }

  @override
  Future<String> register(UserModel user) async {
    final body = user.toJson();
    final response = await client.post(
      Uri.parse('$baseUrl/Auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    final Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));

    if (response.statusCode == 200) {
      return data['msg'];
    } else {
      throw ServerException(data['msg']);
    }
  }
}
