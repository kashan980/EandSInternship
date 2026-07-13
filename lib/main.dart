import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

abstract class Item {
  String get name;
  double get price;
}

class Phone implements Item {
  @override
  final String name;

  @override
  final double price;

  Phone({required this.name, required this.price});
}

class PurchaseButton<T extends Item> extends StatelessWidget {
  final T item;

  const PurchaseButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Purchased ${item.name} for \$${item.price.toString()} ',
            ),
          ),
        );
      },
      child: Text("Purchase ${item.name}"),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final phone = Phone(name: "Samsung S24", price: 850);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Generic Button")),
        body: Center(child: PurchaseButton<Phone>(item: phone)),
      ),
    );
  }
}
