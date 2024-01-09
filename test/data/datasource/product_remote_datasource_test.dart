import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/data/datasource/product_remote_datasource.dart';
import 'package:vegan/data/utils/constant.dart';
import 'package:vegan/data/utils/exception.dart';

import '../../dummy_data/object_dummy.dart';
import '../../read_json.dart';
import '../../test_helper.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProductRemoteDatasourceImpl productRemoteDatasourceImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    mockHttpClient = MockHttpClient();
    productRemoteDatasourceImpl =
        ProductRemoteDatasourceImpl(client: mockHttpClient);
  });

  group('Product', () {
    test('Should be get list product if request success', () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/api/product'), headers: {}))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/product.json'), 200));
      final result = await productRemoteDatasourceImpl.getAllProduct();

      expect(result, equals([tProductModel]));
    });
    test('Should be ServerException if request failed', () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/api/product'), headers: {}))
          .thenThrow(ServerException('Not Found'));
      final result = productRemoteDatasourceImpl.getAllProduct();

      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
