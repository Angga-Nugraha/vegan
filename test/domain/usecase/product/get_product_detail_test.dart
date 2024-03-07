import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/domain/usecase/Product/get_product_detail.dart';

import '../../../dummy_data/object_dummy.dart';
import '../../../test_helper.mocks.dart';

void main() {
  late GetProductDetail getProductDetail;
  late MockProductRepository mockProductRepository;
  String id = "6598078eb523ef0e3393abce";

  setUp(() {
    mockProductRepository = MockProductRepository();
    getProductDetail =
        GetProductDetail(productRepository: mockProductRepository);
  });

  test("Should be return Right(Product) from product repositories", () async {
    when(mockProductRepository.getProductDetail(id))
        .thenAnswer((_) async => Right(tProduct));

    final result = await getProductDetail.execute(id);

    expect(result, Right(tProduct));
  });
}
