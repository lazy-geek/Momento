import 'package:flutter/material.dart';
import 'package:notes/utils/app_colors.dart';

final ThemeData AppThemeDark = ThemeData(
  brightness: Brightness.dark,
  accentColor: kAccentColor,
  backgroundColor: kBackgroundColorDark,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    actionsIconTheme: IconThemeData(color: Colors.grey.shade400),
    backgroundColor: kAppBarColorDark,
    titleTextStyle: TextStyle(color: Colors.grey.shade400),
  ),
  cardColor: Color(0xFF3f475a),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Color(0xEEFFFFFF)),
    headline2: TextStyle(color: Colors.white),
    headline3: TextStyle(color: Colors.grey.shade400),
    overline: TextStyle(color: Colors.grey.shade400),
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
);

final ThemeData AppThemeLight = ThemeData(
  brightness: Brightness.light,
  accentColor: kAccentColor,
  backgroundColor: kBackgroundColorLight,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    actionsIconTheme: IconThemeData(color: Colors.black54),
    backgroundColor: kAppBarColorLight,
    titleTextStyle: TextStyle(color: Colors.grey.shade700),
  ),
  cardColor: Colors.grey.shade400.withOpacity(0.8),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.black),
    bodyText2: TextStyle(color: Colors.black),
    headline2: TextStyle(color: Colors.black54),
    headline3: TextStyle(color: Colors.black54),
    overline: TextStyle(color: Colors.grey.shade700),
  ),
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
);

extension FabTheme on ThemeData {
  Color get fabBackgroundColor {
    if (this.brightness == Brightness.dark) {
      return kFabColorDark;
    } else {
      return kFabColorLight;
    }
  }
}
