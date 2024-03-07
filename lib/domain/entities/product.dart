import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  // final String userId;
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

  const Product({
    required this.id,
    // required this.userId,
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

  @override
  List<Object?> get props => [
        id,
        // userId,
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
