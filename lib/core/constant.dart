import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

const baseUrl = "http://10.0.2.2:3000";
// const baseUrl = "http://localhost:3000";

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

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
