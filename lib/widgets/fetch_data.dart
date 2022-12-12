import 'package:http/http.dart' as http;
import 'package:coffe/model/coffee.dart';
import 'dart:convert';

class CoffeeApi {
  static Future<String> CoffeeData(String type) async {
    http.Response response =
        await http.get(Uri.parse('https://api.sampleapis.com/coffee/$type'));
    String data = response.body;

    return data;
  }

  static Future<List<Coffee>> getData() async {
    List<Coffee> coffeeList = [];
    var apiResponse = await CoffeeData('hot');
    var decode = jsonDecode(apiResponse);
    for (var item in decode as List<dynamic>) {
      var title = item["title"];
      var description = item["description"];
      var image = item["image"];
      var id = item["id"];
      List<String> ingredientList = [];
      for (var ingredient in item['ingredients']) {
        ingredientList.add(ingredient);
      }

      var addNewItem = (Coffee(
        title: title,
        description: description,
        image: image,
        ingredients: ingredientList,
        id: id,
      ));
      coffeeList.add(addNewItem);
    }
    return coffeeList;
  }
}
