import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vegan/data/datasource/session_manager.dart';
import 'package:vegan/data/model/auth_model.dart';
import 'package:vegan/data/model/user_model.dart';
import 'package:vegan/data/utils/exception.dart';
import 'package:vegan/domain/entities/user.dart';

import '../utils/constant.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String email, String password);
  Future<String> logout();
  Future<String> register(User user);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl(this.client);

  final Session session = Session();

  @override
  Future<AuthModel> login(String email, String password) async {
    final response = await client.post(Uri.parse('$baseUrl/Auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"email": email, "password": password}));

    final Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));

    await session.updateCookie(response);

    if (response.statusCode == 200) {
      return AuthModel.fromJson(data);
    } else {
      throw ServerException(data['msg']);
    }
  }

  @override
  Future<String> logout() async {
    final response = await client.delete(Uri.parse('$baseUrl/Auth/logout'),
        headers: session.headers);
    final Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));

    await session.updateCookie(response);

    if (response.statusCode == 200) {
      return data['msg'];
    } else {
      throw ServerException('Something went wrong');
    }
  }

  @override
  Future<String> register(User user) async {
    final body = UserModel.fromEntity(user).toJson();
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
