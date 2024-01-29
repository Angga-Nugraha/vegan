import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/upload.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final Upload upload;
  UploadBloc({required this.upload}) : super(UploadInitial()) {
    on<Uploaded>((event, emit) async {
      emit(UploadLoading());

      final result = await upload.execute(event.image);

      result.fold(
        (failure) => emit(UploadError(message: failure.message)),
        (data) => emit(UploadSuccess(message: data)),
      );
    });
  }
}
