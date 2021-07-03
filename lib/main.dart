import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/business_logic/providers/providers.dart';
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
    return Consumer(
      builder: (context, watch, child) {
        ThemeMode themeMode = watch(ThemeManagerProvider).currentThemeMode;

        return MaterialApp(
          title: 'Notes',
          darkTheme: AppThemeDark,
          theme: AppThemeLight,
          themeMode: themeMode,
          home: HomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
