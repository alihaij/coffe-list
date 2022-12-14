import 'package:coffe/main.dart';
import 'package:coffe/views/coffee_details_screen.dart';
import 'package:coffe/widgets/change_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:coffe/model/coffee.dart';
import 'package:coffe/widgets/coffee_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../provider/coffee_provider.dart';

enum CoffeeType { hot, iced }

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with RouteAware {
  // List<Coffee> _hotCoffeeList = [];
  // List<Coffee> _icedCoffeeList = [];
  List<Coffee> _coffeeList = [];
  var coffeeType = CoffeeType.hot;
  // String _currentPage = 'Hot Coffee';

  Future<void> refresh(context) async {
    fetchData();
    // print(coffeeType.name);
    // setState(() {
    //   _isLoading = true;
    // });
    // if (_currentPage == 'Hot Coffee') {
    //   await Provider.of<CoffeeProvider>(context, listen: false).getDataHot();
    //   _coffeeList =
    //       Provider.of<CoffeeProvider>(context, listen: false).hotCoffes;
    // } else {
    //   await Provider.of<CoffeeProvider>(context, listen: false).getDataCold();
    //   _coffeeList =
    //       Provider.of<CoffeeProvider>(context, listen: false).coldCoffes;
    // }
    // setState(() {
    //   _isLoading = false;
    // });
  }

  bool _isLoading = false;
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  // }

  @override
  void initState() {
    super.initState();
    fetchData();
    // setState(() {
    //   _isLoading = true;
    // });
    // Provider.of<CoffeeProvider>(context, listen: false)
    //     .getDataHot()
    //     .then((value) {
    //   Provider.of<CoffeeProvider>(context, listen: false)
    //       .getDataCold()
    //       .then((value) {
    //     _hotCoffeeList =
    //         Provider.of<CoffeeProvider>(context, listen: false).hotCoffes;
    //     _icedCoffeeList =
    //         Provider.of<CoffeeProvider>(context, listen: false).coldCoffes;
    //     _coffeeList = _hotCoffeeList;
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   });
    // });
  }

  fetchData() async {
    setState(() {
      _isLoading = true;
    });
    final provider = Provider.of<CoffeeProvider>(context, listen: false);
    await provider.getData(coffeeType).then((value) {
      _coffeeList = provider.coffeeList;
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.coffee),
            SizedBox(
              width: 10,
            ),
            Text('Coffee'),
          ],
        ),
        actions: const [ChangeThemeButtonWidget()],
      ),
      body: _isLoading
          ? const SpinKitThreeBounce(
              color: Colors.amber,
            )
          : RefreshIndicator(
              child: ListView.builder(
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
                        title: _coffeeList[index].title!,
                        image: _coffeeList[index].image!,
                        id: _coffeeList[index].id!),
                  );
                },
              ),
              onRefresh: () => refresh(context),
            ),
      bottomNavigationBar: GNav(tabs: [
        GButton(
          icon: Icons.local_fire_department_sharp,
          text: 'Hot Coffee',
          gap: 8,
          onPressed: () {
            setState(() {
              // _currentPage = 'Hot Coffee';
              // _coffeeList = _hotCoffeeList;
              coffeeType = CoffeeType.hot;
            });
            fetchData();
          },
        ),
        GButton(
          icon: Icons.ac_unit_rounded,
          text: 'Iced Coffee',
          gap: 8,
          onPressed: () {
            setState(() {
              // _currentPage = 'Iced Coffee';
              // _coffeeList = _icedCoffeeList;
              coffeeType = CoffeeType.iced;
            });
            fetchData();
          },
        )
      ]),
    );
  }
}