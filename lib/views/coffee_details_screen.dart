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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(item.image!),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 15),
              child: const Text(
                'Description: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                item.description!,
                style: const TextStyle(fontSize: 17),
              ),
            ),
            Container(
              padding:const EdgeInsets.only(left: 10, top: 15),
              child: const Text(
                'Ingedients: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(bottom: 25, top: 15, right: 15, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var ing in item.ingredients!)
                    Text(
                      '* $ing',
                      style: const TextStyle(fontSize: 17),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
