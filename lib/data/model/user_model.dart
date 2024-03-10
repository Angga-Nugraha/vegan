import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? confPassword;
  final AddressModel? address;
  final String? role;
  final String? image;
  final String? token;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.confPassword,
    this.address,
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
        address: AddressModel.fromJson(json["address"]),
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
      address: address!.toEntity(),
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

class AddressModel extends Equatable {
  final String? detailAddress;
  final String? provinsi;
  final String? kota;
  final String? kecamatan;
  final GeoModel geoModel;
  final int? postalCode;

  const AddressModel({
    this.detailAddress,
    this.provinsi,
    this.kota,
    this.kecamatan,
    required this.geoModel,
    this.postalCode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        detailAddress: json["detail_address"],
        provinsi: json["provinsi"],
        kota: json["kota"],
        kecamatan: json["kecamatan"],
        postalCode: json["postal_code"],
        geoModel: GeoModel.fromJson(json["geo"]),
      );

  factory AddressModel.fromEntity(Address address) => AddressModel(
        detailAddress: address.detailAddress,
        provinsi: address.provinsi,
        kota: address.kota,
        kecamatan: address.kecamatan,
        postalCode: address.postalCode,
        geoModel: GeoModel.fromEntity(address.geo),
      );

  Map<String, dynamic> toJson() => {
        "detail_address": detailAddress,
        "provinsi": provinsi,
        "kota": kota,
        "kecamatan": kecamatan,
        "postal_code": postalCode,
        "geo": geoModel.toJson()
      };

  Address toEntity() => Address(
        detailAddress: detailAddress,
        provinsi: provinsi,
        kota: kota,
        kecamatan: kecamatan,
        postalCode: postalCode,
        geo: geoModel.toEntity(),
      );

  @override
  List<Object?> get props => [
        detailAddress,
        provinsi,
        kota,
        kecamatan,
        postalCode,
        geoModel,
      ];
}

class GeoModel extends Equatable {
  final double? lat;
  final double? long;

  const GeoModel({
    this.lat,
    this.long,
  });

  factory GeoModel.fromJson(Map<String, dynamic> json) => GeoModel(
        lat: json["lat"],
        long: json["long"],
      );

  factory GeoModel.fromEntity(Geo geo) => GeoModel(
        lat: geo.lat,
        long: geo.long,
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
      };

  Geo toEntity() => Geo(
        lat: lat,
        long: long,
      );

  @override
  List<Object?> get props => [
        lat,
        long,
      ];
}
