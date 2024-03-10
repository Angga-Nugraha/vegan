import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:vegan/data/datasource/upload.dart';
import 'package:vegan/core/exception.dart';
import 'package:vegan/core/failure.dart';
import 'package:vegan/domain/repositories/upload_repositories.dart';

class UploadRepositoryImpl implements UploadRepository {
  final UploadImage uploadImage;

  const UploadRepositoryImpl({required this.uploadImage});

  @override
  Future<Either<Failure, String>> uploadUserImg(File image) async {
    try {
      final result = await uploadImage.uploadUserImg(image);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (err) {
      return Left(CommonFailure(err.toString()));
    }
  }
}
