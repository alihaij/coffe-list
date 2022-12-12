import 'package:flutter/material.dart';
import 'package:coffe/views/home_page.dart';
import 'package:coffe/provider/theme_provider.dart';

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
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee',
      themeMode: ThemeMode.system,
      theme: MyTheme.darkTheme ,
      darkTheme: MyTheme.darkTheme,
      home: Home(),
    );
  }
}
