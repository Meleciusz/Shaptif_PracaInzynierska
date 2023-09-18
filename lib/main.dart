import 'package:flutter/material.dart';

import 'WelcomeScreen/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Shaptif',
      home: WelcomeScreen(),
    );
  }
}