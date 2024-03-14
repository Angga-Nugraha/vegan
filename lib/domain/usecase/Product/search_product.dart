import 'package:dartz/dartz.dart';
import 'package:vegan/domain/repositories/product_repositories.dart';

import '../../../core/failure.dart';
import '../../entities/product.dart';

class SearchProduct {
  final ProductRepository productRepository;

  const SearchProduct({required this.productRepository});

  Future<Either<Failure, List<Product>>> execute(String query) async {
    return await productRepository.search(query);
  }
}
