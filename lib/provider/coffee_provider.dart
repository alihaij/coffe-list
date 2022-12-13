import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/coffee.dart';
import 'package:http/http.dart' as http;

class CoffeeProvider with ChangeNotifier {
  List<Coffee> _hotCoffee = [];
  List<Coffee> _coldCoffee = [];

  static Future<String> coffeeData(String type) async {
    http.Response response =
        await http.get(Uri.parse('https://api.sampleapis.com/coffee/$type'));
    String data = response.body;

    return data;
  }

  Future<void> getDataHot() async {
    List<Coffee> coffeeList = [];
    var apiResponse = await coffeeData('hot');
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
    _hotCoffee = coffeeList;
    notifyListeners();
  }

  Future<void> getDataCold() async {
    List<Coffee> coffeeList = [];
    var apiResponse = await coffeeData('iced');
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
    _coldCoffee = coffeeList;
    notifyListeners();
  }

  List<Coffee> get hotCoffes {
    return [..._hotCoffee];
  }

  List<Coffee> get coldCoffes {
    return [..._coldCoffee];
  }
}
