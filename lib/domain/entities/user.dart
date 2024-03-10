import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? confPassword;
  final Address? address;
  final String? role;
  final String? image;
  final String? token;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const User({
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

class Address extends Equatable {
  final String? detailAddress;
  final String? provinsi;
  final String? kota;
  final String? kecamatan;
  final int? postalCode;
  final Geo geo;

  const Address({
    this.detailAddress,
    this.provinsi,
    this.kota,
    this.kecamatan,
    this.postalCode,
    required this.geo,
  });

  @override
  List<Object?> get props => [
        detailAddress,
        provinsi,
        kota,
        kecamatan,
        postalCode,
        geo,
      ];
}

class Geo extends Equatable {
  final double? lat;
  final double? long;

  const Geo({
    this.lat,
    this.long,
  });

  @override
  List<Object?> get props => [
        lat,
        long,
      ];
}
