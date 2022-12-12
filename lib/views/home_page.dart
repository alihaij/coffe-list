import 'package:coffe/views/coffee_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:coffe/widgets/fetch_data.dart';
import 'package:coffe/model/coffee.dart';
import 'package:coffe/widgets/coffee_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Coffee> _coffeeList = [];
  @override
  void initState() {
    super.initState();
    getCoffee();
  }

  Future<void> getCoffee() async {
    _coffeeList = await CoffeeApi.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.coffee),
          SizedBox(
            width: 10,
          ),
          Text('Coffee')
        ],
      )),
      body: ListView.builder(
        itemCount: _coffeeList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CoffeeDetails(item: _coffeeList[index])),
              );
            },
            child: CoffeeCard(
                title: _coffeeList[index].title,
                image: _coffeeList[index].image,
                id: _coffeeList[index].id),
          );
        },
      ),
    );
  }
}
