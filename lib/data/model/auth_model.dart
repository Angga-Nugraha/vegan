import 'package:equatable/equatable.dart';
import 'package:vegan/domain/entities/auth.dart';

class AuthModel extends Equatable {
  final String status;
  final String id;
  final String accessToken;

  const AuthModel({
    required this.status,
    required this.id,
    required this.accessToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        status: json["status"],
        id: json["id"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "accessToken": accessToken,
      };

  Auth toEntity() => Auth(
        status: status,
        id: id,
        accessToken: accessToken,
      );

  @override
  List<Object?> get props => [
        status,
        id,
        accessToken,
      ];
}
