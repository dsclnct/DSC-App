import 'package:flutter/material.dart';

class Themechanger with ChangeNotifier {
  bool isDarkMode = false;
  getDarkMode() => this.isDarkMode;
  void changeDarkMode(isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
}

class AppTheme {
  get darkTheme => ThemeData(
        hintColor: Colors.black,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.light(
          primary: Colors.black,
          onPrimary: Colors.black,
          primaryVariant: Colors.black,
          secondary: Colors.red,
        ),
        cardTheme: CardTheme(
          color: Colors.black,
        ),
        iconTheme: IconThemeData(
          color: Colors.white54,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
          ),
          headline1: TextStyle(
            color: Colors.white,
          ),
          headline2: TextStyle(
            color: Colors.white,
          ),
          headline3: TextStyle(
            color: Colors.white,
          ),
          headline4: TextStyle(
            color: Colors.white,
          ),
          headline5: TextStyle(
            color: Colors.white,
          ),
        ),
      );
}
