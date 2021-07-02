import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/presentation/pages/home_page.dart';
import 'package:notes/utils/themes.dart';

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
      title: 'Notes',
      darkTheme: AppThemeDark,
      theme: AppThemeLight,
      themeMode: ThemeMode.dark,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
