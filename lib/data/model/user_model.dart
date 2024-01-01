import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends Equatable {
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

  const UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        address: json["address"],
        role: json["role"],
        image: json["image"],
        token: json["token"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  factory UserModel.fromEntity(User user) => UserModel(
        name: user.name,
        email: user.email,
        phone: user.phone,
        password: user.password,
        confPassword: user.confPassword,
        address: user.address,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "confPassword": confPassword,
        "address": address,
      };

  User toEntity() => User(
      id: id,
      name: name,
      email: email,
      phone: phone,
      password: password,
      confPassword: confPassword,
      address: address,
      role: role,
      token: token,
      image: image,
      createdAt: createdAt,
      updatedAt: updatedAt);

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
