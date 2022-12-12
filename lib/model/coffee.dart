import 'package:coffe/widgets/fetch_data.dart';

class Coffee {
  final String title;
  final String description;
  final List<String> ingredients;
  final String image;
  final int id;

  Coffee(
      {required this.title,
      required this.description,
      required this.ingredients,
      required this.image,
      required this.id});
}
