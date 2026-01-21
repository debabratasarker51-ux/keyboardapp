import 'package:flutter/material.dart';
import 'package:myapp/keyboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Custom Keyboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const KeyboardScreen(),
    );
  }
}
