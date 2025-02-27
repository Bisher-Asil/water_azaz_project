import 'package:flutter/material.dart';

const Color greyBlue = Color(0xff597393);
const Color greyWhite = Color(0xffDDEAF3);
const Color topBarLightGreen= Color.fromARGB(255, 85, 139, 47);
const Color busyColor = Color(0xFFF2C94C);
const Color availableColor = Color(0xFF37D858);
const Color offlineColor = Color(0xFFEB5757);
const Color nullColor = Color(0xFF222733);



class CustomAppTheme {
  CustomAppTheme._internal();

  static final CustomAppTheme instance = CustomAppTheme._internal();

  ThemeData lightThemeData() => ThemeData.light().copyWith(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        canvasColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          suffixIconColor: Colors.black,
          border: UnderlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.none),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // Button background
            foregroundColor: Colors.white, // Button text
          ),
        ),
      );

  ThemeData darkThemeData() => ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Button background
            foregroundColor: Colors.black, // Button text
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          suffixIconColor: Colors.white,
          border: UnderlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.none),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      );

  bool isAppInDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}

