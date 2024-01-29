import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:vegan/data/utils/failure.dart';

abstract class UploadRepository{
  Future<Either<Failure, String>> uploadUserImg(File image);
}