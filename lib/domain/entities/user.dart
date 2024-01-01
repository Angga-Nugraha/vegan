import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String? confPassword;
  final String address;
  final String? role;
  final String? image;
  final String? token;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.confPassword,
    required this.address,
    this.role,
    this.image,
    this.token,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        password,
        confPassword,
        address,
        role,
        image,
        token,
        createdAt,
        updatedAt,
      ];
}
