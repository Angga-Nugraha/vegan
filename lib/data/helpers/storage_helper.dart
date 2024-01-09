import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static SecureStorageHelper? _secureStorageHelper;

  SecureStorageHelper._instance() {
    _secureStorageHelper = this;
  }

  factory SecureStorageHelper() =>
      _secureStorageHelper ?? SecureStorageHelper._instance();

  final secureStorage = const FlutterSecureStorage();

  Future<void> writeData(String key, String data) async {
    await secureStorage.write(key: key, value: data);
  }

  Future<String?> readData(String key) async {
    return await secureStorage.read(key: key);
  }

  Future<void> deleteSecureStorage() async {
    await secureStorage.delete(key: 'auth');
    await secureStorage.delete(key: 'cookie');
    await secureStorage.deleteAll();
  }
}
