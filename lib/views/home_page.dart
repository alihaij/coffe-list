import 'package:coffe/views/coffee_details_screen.dart';
import 'package:coffe/widgets/change_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:coffe/widgets/fetch_data.dart';
import 'package:coffe/model/coffee.dart';
import 'package:coffe/widgets/coffee_card.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Coffee> _hotCoffeeList = [];
  List<Coffee> _icedCoffeeList = [];
  List<Coffee> _coffeeList = [];

  @override
  void initState() {
    super.initState();
    getCoffee().then((value) {
      setState(() {
        _coffeeList = _hotCoffeeList;
      });
    });
  }

  Future<void> getCoffee() async {
    _hotCoffeeList = await CoffeeApi.getDataHot();
    _icedCoffeeList = await CoffeeApi.getDataCold();
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
            Text('Coffee'),
          ],
        ),
        actions: [ChangeThemeButtonWidget()],
      ),
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
      bottomNavigationBar: GNav(tabs: [
        GButton(
          icon: Icons.coffee,
          text: 'Hot Coffee',
          gap: 8,
          onPressed: () {
            setState(() {
              _coffeeList = _hotCoffeeList;
            });
          },
        ),
        GButton(
          icon: Icons.coffee_outlined,
          text: 'Iced Coffee',
          onPressed: () {
            setState(() {
              _coffeeList = _icedCoffeeList;
            });
          },
        )
      ]),
    );
  }
}
