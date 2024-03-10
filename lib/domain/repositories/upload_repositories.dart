import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:vegan/core/failure.dart';

abstract class UploadRepository {
  Future<Either<Failure, String>> uploadUserImg(File image);
}
