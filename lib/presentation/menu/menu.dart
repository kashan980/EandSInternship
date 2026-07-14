import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu")),
      body: Center(
        // 1. Use a Column to stack widgets vertically
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const GenericText<String>(
              value:
                  'Evamp & Sangaa Internship Summer 2026\n Mobile App Development'
                  '',
            ),

            const SizedBox(height: 20),
            const AppButton(text: "Click Me", backgroundColor: Colors.green),
          ],
        ),
      ),
    );
  }
}

class GenericText<T> extends StatelessWidget {
  final T value;
  final Color textColor;

  const GenericText({
    super.key,
    required this.value,
    this.textColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      value.toString(),
      style: TextStyle(
        color: textColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;

  const AppButton({
    super.key,
    required this.text,
    this.backgroundColor = Colors.red,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Button "$text" tapped!')));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.touch_app, color: textColor),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
