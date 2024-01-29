part of 'upload_bloc.dart';

sealed class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object> get props => [];
}

final class Uploaded extends UploadEvent {
  final File image;

  const Uploaded({required this.image});

  @override
  List<Object> get props => [image];
}
