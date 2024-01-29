import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:vegan/data/helpers/storage_helper.dart';
import 'package:vegan/data/utils/constant.dart';

import '../utils/exception.dart';

abstract class UploadImage {
  Future<String> uploadUserImg(File image);
}

class UploadImageImpl implements UploadImage {
  final SecureStorageHelper storage;

  const UploadImageImpl({required this.storage});

  @override
  Future<String> uploadUserImg(File image) async {
    final auth = await storage.readData('auth');
    Map<String, dynamic> authData = {};
    var userId = '';
    var token = '';
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      authData = json.decode(auth!);
      userId = authData['id'];
      token = authData['accessToken'];
    }
    
    final stream = http.ByteStream(DelegatingStream(image.openRead()));
    final length = await image.length();
    final request = http.MultipartRequest(
        'PATCH', Uri.parse('$baseUrl/api/upload/user/$userId'))
      ..headers['authorization'] = 'Bearer $token'
      ..files.add(http.MultipartFile(
        'user',
        stream,
        length,
        filename: path.basename(image.path),
      ));

    final response = await request.send();
    final resp = await http.Response.fromStream(response);

    Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(resp.body));

    if (response.statusCode == 200) {
      return data['msg'];
    } else {
      throw ServerException(data['msg']);
    }
  }
}
