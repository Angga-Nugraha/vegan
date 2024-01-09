import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:vegan/domain/entities/product.dart';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str)['data'].map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String description;
  final int price;
  final double ratting;
  final int stock;
  final int weight;
  final List<String> category;
  final List<dynamic> imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.price,
    required this.ratting,
    required this.stock,
    required this.weight,
    required this.category,
    required this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        ratting: json["ratting"]?.toDouble(),
        stock: json["stock"],
        weight: json["weight"],
        category: List<String>.from(json["category"].map((x) => x)),
        imageUrl: List<dynamic>.from(json["imageUrl"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "title": title,
        "description": description,
        "price": price,
        "ratting": ratting,
        "stock": stock,
        "weight": weight,
        "category": List<dynamic>.from(category.map((x) => x)),
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
      };

  Product toEntity() => Product(
        id: id,
        userId: userId,
        title: title,
        description: description,
        price: price,
        ratting: ratting,
        stock: stock,
        weight: weight,
        category: category,
        imageUrl: imageUrl,
        createdAt: createdAt!,
        updatedAt: updatedAt!,
      );

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        description,
        price,
        ratting,
        stock,
        weight,
        category,
        imageUrl,
        createdAt,
        updatedAt,
      ];
}
