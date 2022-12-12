import 'package:flutter/material.dart';

class Coffee with ChangeNotifier {
  final String? title;
  final String? description;
  final List<String>? ingredients;
  final String? image;
  final int? id;

  Coffee({
    this.title,
    this.description,
    this.ingredients,
    this.image,
    this.id,
  });
}
