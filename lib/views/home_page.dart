import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:coffe/widgets/fetch_data.dart';
import 'package:coffe/model/coffee.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    forPrint();
  }

  List<Coffee> coffeeList = [];
  Future<void> forPrint() async {
    var apiResponse = await CoffeeApi().CoffeeData('hot');
    var decode = jsonDecode(apiResponse);
    // print(decode);
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

    coffeeList.forEach(
      (element) => print(element.title),
    );
    // print(Coffee.fromJson(decode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Coffee')),
      body:
          Container(margin: EdgeInsets.all(12), child: masonryLayout(context)),
    );
  }
}

Widget masonryLayout(BuildContext context) {
  return MasonryGridView.builder(
      scrollDirection: Axis.vertical,
      crossAxisSpacing: 8,
      mainAxisSpacing: 6,
      gridDelegate:
          SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 20,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network("https://source.unsplash.com/random?sig=$index"),
        );
      });
}
