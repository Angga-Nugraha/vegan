import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String status;
  final String? id;
  final String? accessToken;
  final String? message;

  const Auth({
    required this.status,
    this.id,
    this.accessToken,
    this.message,
  });

  @override
  List<Object?> get props => [
        status,
        id,
        accessToken,
        message,
      ];
}
