import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/pages/homePage.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      themeMode: ThemeMode.dark,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
