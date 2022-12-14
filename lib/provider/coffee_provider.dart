import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/coffee.dart';
import 'package:http/http.dart' as http;
import '../views/home_page.dart';

class CoffeeProvider with ChangeNotifier {
  // List<Coffee> _hotCoffee = [];
  // List<Coffee> _coldCoffee = [];
  List<Coffee> _coffeeList = [];

  static Future<String> coffeeData(String type) async {
    try {
      http.Response response =
          await http.get(Uri.parse('https://api.sampleapis.com/coffee/$type'));
      String data = response.body;
      return data;
    } on Exception catch (e) {
      print(e);
      return (e.toString());
    }
  }

  Future<void> getData(CoffeeType coffeeType) async {
    _coffeeList.clear();
    try {
      var apiResponse = await coffeeData(coffeeType.name);
      var decode = jsonDecode(apiResponse);
      (decode as List<dynamic>).forEach((item) {
        _coffeeList.add(Coffee(
          title: item['title'],
          description: item['description'],
          image: item['image'],
          ingredients: List<String>.from(item['ingredients']),
          id: item['id'],
        ));
      });
      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
  }

  // Future<void> getDataHot() async {
  //   List<Coffee> coffeeList = [];
  //   var apiResponse = await coffeeData('hot');
  //   var decode = jsonDecode(apiResponse);
  //   for (var item in decode as List<dynamic>) {
  //     var title = item["title"];
  //     var description = item["description"];
  //     var image = item["image"];
  //     var id = item["id"];
  //     List<String> ingredientList = [];
  //     for (var ingredient in item['ingredients']) {
  //       ingredientList.add(ingredient);
  //     }

  //     var addNewItem = (Coffee(
  //       title: title,
  //       description: description,
  //       image: image,
  //       ingredients: ingredientList,
  //       id: id,
  //     ));
  //     coffeeList.add(addNewItem);
  //   }
  //   _hotCoffee = coffeeList;
  //   notifyListeners();
  // }

  // Future<void> getDataCold() async {
  //   List<Coffee> coffeeList = [];
  //   var apiResponse = await coffeeData('iced');
  //   var decode = jsonDecode(apiResponse);
  //   for (var item in decode as List<dynamic>) {
  //     var title = item["title"];
  //     var description = item["description"];
  //     var image = item["image"];
  //     var id = item["id"];
  //     List<String> ingredientList = [];
  //     for (var ingredient in item['ingredients']) {
  //       ingredientList.add(ingredient);
  //     }

  //     var addNewItem = (Coffee(
  //       title: title,
  //       description: description,
  //       image: image,
  //       ingredients: ingredientList,
  //       id: id,
  //     ));
  //     coffeeList.add(addNewItem);
  //   }
  //   _coldCoffee = coffeeList;
  //   notifyListeners();
  // }

  List<Coffee> get coffeeList {
    return [..._coffeeList];
  }

//   List<Coffee> get hotCoffes {
//     return [..._hotCoffee];
//   }

//   List<Coffee> get coldCoffes {
//     return [..._coldCoffee];
//   }
}
