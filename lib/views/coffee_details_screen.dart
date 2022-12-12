import 'package:flutter/material.dart';

import '../model/coffee.dart';

class CoffeeDetails extends StatelessWidget {
  final Coffee item;
  const CoffeeDetails({super.key, required this.item});
  static const routName = '/coffee-details';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${item.title} Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image(
                image: NetworkImage(item.image),
              ),
            ),
            Container(
              child: Text('Description: '),
            ),
            Container(
              child: Text(item.description),
            ),
            Container(
              child: Text('Ingedients: '),
            ),
            Container(
              child: Column(
                children: [for (var ing in item.ingredients) Text(ing)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
