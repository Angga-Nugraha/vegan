import 'package:flutter/material.dart';

const baseUrl = "http://10.0.2.2:3000";

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

String convertUrl(String url) {
  return url.replaceFirst("http://localhost:3000", baseUrl);
}

final PageController controller = PageController();

List<String> category = [
  'Sayur',
  'Buah',
  'Umbi',
  'Kacang',
];
