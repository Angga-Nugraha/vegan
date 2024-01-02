import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vegan/data/helpers/storage_helper.dart';

class Session {
  static Session? _session;

  Session._instance() {
    _session = this;
  }

  factory Session() => _session ?? Session._instance();

  final Map<String, String> _headers = {};
  final SecureStorageHelper storage = SecureStorageHelper();

  Map<String, String> get headers => _headers;

  Future<void> updateCookie(http.Response response) async {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      _headers['Cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
    await storage.writeData('cookie', json.encode(headers));
  }
}
