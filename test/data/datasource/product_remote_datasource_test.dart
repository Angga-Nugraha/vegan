import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/data/datasource/product_remote_datasource.dart';
import 'package:vegan/data/helpers/storage_helper.dart';
import 'package:vegan/data/utils/constant.dart';
import 'package:vegan/data/utils/exception.dart';

import '../../dummy_data/object_dummy.dart';
import '../../read_json.dart';
import '../../test_helper.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProductRemoteDatasourceImpl productRemoteDatasourceImpl;

  late SecureStorageHelper storage;
  late MockHttpClient mockHttpClient;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    mockHttpClient = MockHttpClient();

    storage = SecureStorageHelper();
    productRemoteDatasourceImpl = ProductRemoteDatasourceImpl(
      client: mockHttpClient,
      storage: storage,
    );
  });

  group('Product', () {
    group('Get All Product', () {
      test('Should be get list product if request success', () async {
        when(mockHttpClient.get(Uri.parse('$baseUrl/api/product'), headers: {}))
            .thenAnswer((_) async =>
                http.Response(readJson('dummy_data/product.json'), 200));
        final result = await productRemoteDatasourceImpl.getAllProduct();

        expect(result, equals([tProductModel]));
      });

      test('Should be ServerException if response status code 500', () async {
        when(mockHttpClient.get(Uri.parse('$baseUrl/api/product'), headers: {}))
            .thenAnswer((_) async => http.Response(
                readJson('dummy_data/response_failed.json'), 500));
        final result = productRemoteDatasourceImpl.getAllProduct();

        expect(result, throwsA(isA<ServerException>()));
      });
    });

    group('Get Product Detail By Id', () {
      String id = "6598078eb523ef0e3393abce";
      test('Should be get product detail if request success', () async {
        when(mockHttpClient
                .get(Uri.parse('$baseUrl/api/product/$id'), headers: {}))
            .thenAnswer((_) async =>
                http.Response(readJson('dummy_data/product_detail.json'), 200));
        final result = await productRemoteDatasourceImpl.getProductDetail(id);

        expect(result, equals(tProductModel));
      });

      test(
          'Should be ServerException if getDetailProduct response status code 500',
          () async {
        when(mockHttpClient
            .get(Uri.parse('$baseUrl/api/product/$id'),
                headers: {})).thenAnswer((_) async =>
            http.Response(readJson('dummy_data/response_failed.json'), 500));
        final result = productRemoteDatasourceImpl.getProductDetail(id);

        expect(result, throwsA(isA<ServerException>()));
      });
    });
  });
}
