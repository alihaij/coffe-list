import 'package:coffe/provider/coffee_provider.dart';
import 'package:flutter/material.dart';
import 'package:coffe/views/home_page.dart';
import 'package:coffe/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import 'model/coffee.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: Coffee()),
              ChangeNotifierProvider.value(value: CoffeeProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Coffee',
              themeMode: themeProvider.themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              home: const Home(),
            ),
          );
        },
      );
}
