import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/data/repositories/product_repositories_impl.dart';

import '../../dummy_data/object_dummy.dart';
import '../../test_helper.mocks.dart';

void main() {
  late MockProductRemoteDatasource mockProductRemoteDatasource;
  late ProductRepositoryImpl productRepositoryImpl;

  setUp(() {
    mockProductRemoteDatasource = MockProductRemoteDatasource();
    productRepositoryImpl = ProductRepositoryImpl(
        productRemoteDatasource: mockProductRemoteDatasource);
  });

  group("Product", () {
    test("Should be return Right List of product", () async {
      when(mockProductRemoteDatasource.getAllProduct())
          .thenAnswer((_) async => [tProductModel]);

      final result = await productRepositoryImpl.getAllproduct();
      verify(mockProductRemoteDatasource.getAllProduct());

      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, [tProduct]);
    });
  });
}
