import 'dart:convert';
import 'dart:io';

import 'package:vegan/data/helpers/storage_helper.dart';
import 'package:vegan/data/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:vegan/data/utils/constant.dart';
import 'package:vegan/data/utils/exception.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> getAllProduct();
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final http.Client client;
  final SecureStorageHelper storage;

  const ProductRemoteDatasourceImpl(
      {required this.client, required this.storage});

  @override
  Future<List<ProductModel>> getAllProduct() async {
    final auth = await storage.readData('auth');
    Map<String, String> headers = {};

    //only runs when you are NOT testing
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      final String token = json.decode(auth!)["accessToken"];
      headers = {'authorization': 'Bearer $token'};
    }

    final response = await client.get(
      Uri.parse('$baseUrl/api/product'),
      headers: headers,
    );

    final Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));

    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    } else {
      throw ServerException(data['msg']);
    }
  }
}
