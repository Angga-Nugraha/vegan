import 'package:dartz/dartz.dart';
import 'package:vegan/domain/repositories/product_repositories.dart';

import '../../../data/utils/failure.dart';
import '../../entities/product.dart';

class GetAllProduct {
  final ProductRepository productRepository;

  const GetAllProduct({required this.productRepository});

  Future<Either<Failure, List<Product>>> execute() async {
    return await productRepository.getAllproduct();
  }
}
