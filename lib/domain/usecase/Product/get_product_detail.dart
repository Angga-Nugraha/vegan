import 'package:dartz/dartz.dart';
import 'package:vegan/domain/repositories/product_repositories.dart';

import '../../../data/utils/failure.dart';
import '../../entities/product.dart';

class GetProductDetail {
  final ProductRepository productRepository;

  const GetProductDetail({required this.productRepository});

  Future<Either<Failure, Product>> execute(String id) async {
    return await productRepository.getProductDetail(id);
  }
}
