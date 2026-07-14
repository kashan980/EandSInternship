import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu")),
      body: Center(
        child: AppButton(
          text: "Click Me",
          backgroundColor: Colors.green,
          borderColor: Colors.black,
          textColor: Colors.white,
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;
  final bool isEnabled;
  final bool showIcon;
  const AppButton({
    super.key,
    required this.text,
    this.backgroundColor = Colors.red,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.borderColor = Colors.black,
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
