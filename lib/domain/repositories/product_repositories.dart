import 'package:dartz/dartz.dart';

import '../../core/failure.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllproduct();
  Future<Either<Failure, Product>> getProductDetail(String id);
}
