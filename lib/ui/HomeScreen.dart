import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Container(
          child: Text("Home Screen"),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
