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

enum CoffeeType { iced, hot }

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with RouteAware {
  List<Coffee> _hotCoffeeList = [];
  List<Coffee> _icedCoffeeList = [];
  List<Coffee> _coffeeList = [];
  var _currentPage = CoffeeType.hot;

  Future<void> refresh(context) async {
    setState(() {
      _isLoading = true;
    });
    if (_currentPage == CoffeeType.hot) {
      await Provider.of<CoffeeProvider>(context, listen: false).getDataHot();
      _coffeeList =
          Provider.of<CoffeeProvider>(context, listen: false).hotCoffes;
    } else {
      await Provider.of<CoffeeProvider>(context, listen: false).getDataCold();
      _coffeeList =
          Provider.of<CoffeeProvider>(context, listen: false).coldCoffes;
    }
    setState(() {
      _isLoading = false;
    });
  }

  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    Provider.of<CoffeeProvider>(context, listen: false)
        .getDataHot()
        .then((value) {
      Provider.of<CoffeeProvider>(context, listen: false)
          .getDataCold()
          .then((value) {
        _hotCoffeeList =
            Provider.of<CoffeeProvider>(context, listen: false).hotCoffes;
        _icedCoffeeList =
            Provider.of<CoffeeProvider>(context, listen: false).coldCoffes;
        _coffeeList = _hotCoffeeList;
        setState(() {
          _isLoading = false;
        });
      });
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
          icon: Icons.coffee,
          text: 'Hot Coffee',
          gap: 8,
          onPressed: () async {
            setState(() {
              _currentPage = CoffeeType.hot;
              _coffeeList = _hotCoffeeList;
            });
          },
        ),
        GButton(
          icon: Icons.coffee_outlined,
          text: 'Iced Coffee',
          onPressed: () {
            setState(() {
              _currentPage = CoffeeType.iced;
              _coffeeList = _icedCoffeeList;
            });
          },
        )
      ]),
    );
  }
}
