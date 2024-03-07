import 'package:dartz/dartz.dart';
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
    String id = "6598078eb523ef0e3393abce";
    test("Should be return Right List of product", () async {
      when(mockProductRemoteDatasource.getAllProduct())
          .thenAnswer((_) async => [tProductModel]);

      final result = await productRepositoryImpl.getAllproduct();
      verify(mockProductRemoteDatasource.getAllProduct());

      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, [tProduct]);
    });
    test("Should be return Right of product detail", () async {
      when(mockProductRemoteDatasource.getProductDetail(id))
          .thenAnswer((_) async => tProductModel);

      final result = await productRepositoryImpl.getProductDetail(id);
      verify(mockProductRemoteDatasource.getProductDetail(id));

      expect(result, Right(tProduct));
    });
  });
}
