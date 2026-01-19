import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Center(
        child: Text(
          'Home',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
