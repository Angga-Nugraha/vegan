import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/domain/entities/product.dart';
import 'package:vegan/domain/usecase/Product/get_product.dart';

import '../../../test_helper.mocks.dart';

void main() {
  late GetAllProduct getAllProduct;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getAllProduct = GetAllProduct(productRepository: mockProductRepository);
  });

  final tProductList = <Product>[];
  test("Should be return Right(List<Product>) from product repositories",
      () async {
    when(mockProductRepository.getAllproduct())
        .thenAnswer((_) async => Right(tProductList));

    final result = await getAllProduct.execute();

    expect(result, Right(tProductList));
  });
}
