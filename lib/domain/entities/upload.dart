import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:vegan/data/utils/failure.dart';
import 'package:vegan/domain/repositories/upload_repositories.dart';

class Upload{
  final UploadRepository uploadRepository;

  const Upload({required this.uploadRepository});

  Future<Either<Failure, String>> execute(File image) async {
    return await uploadRepository.uploadUserImg(image);
  }
}