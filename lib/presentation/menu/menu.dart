import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Wrapped the text in a Padding widget
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: GenericText<String>(
                value:
                    'Evamp & Sangaa Internship Summer 2026\nMobile App Development',
              ),
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
      // 2. Added textAlign to center the multi-line text
      textAlign: TextAlign.center,
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
  final bool isEnabled;
  final bool showIcon;

  const AppButton({
    super.key,
    required this.text,
    this.backgroundColor = Colors.red,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.isEnabled = false,
    this.showIcon = false,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled
          ? () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Button "$text" tapped!')));
            }
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon) Icon(Icons.touch_app, color: textColor),
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
