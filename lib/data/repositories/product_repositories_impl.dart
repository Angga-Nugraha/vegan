import 'package:dartz/dartz.dart';
import 'package:vegan/data/datasource/product_remote_datasource.dart';
import 'package:vegan/data/utils/exception.dart';
import 'package:vegan/data/utils/failure.dart';
import 'package:vegan/domain/entities/product.dart';
import 'package:vegan/domain/repositories/product_repositories.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource productRemoteDatasource;

  const ProductRepositoryImpl({required this.productRemoteDatasource});

  @override
  Future<Either<Failure, List<Product>>> getAllproduct() async {
    try {
      final result = await productRemoteDatasource.getAllProduct();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
