import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/domain/entities/product.dart';
import 'package:vegan/domain/usecase/Product/search_product.dart';

import '../../../test_helper.mocks.dart';

void main() {
  late SearchProduct searchProduct;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    searchProduct = SearchProduct(productRepository: mockProductRepository);
  });

  final tProductList = <Product>[];
  const query = "sayur";
  test("Should be return Right(List<Product>) from search product repositories",
      () async {
    when(mockProductRepository.search(query))
        .thenAnswer((_) async => Right(tProductList));

    final result = await searchProduct.execute(query);

    expect(result, Right(tProductList));
  });
}
