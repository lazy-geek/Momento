import 'package:flutter/material.dart';
import 'package:notes/pages/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      home: HomePage(),
    );
  }
}
