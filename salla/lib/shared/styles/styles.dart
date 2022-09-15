import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Janna',
  textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      button: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      caption: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      )),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    titleSpacing: 20,
    iconTheme: IconThemeData(
      color: Colors.black54,
    ),
    color: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(
      color: Colors.grey,
    ),
    elevation: 50,
  ),
);

ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    bodyText2: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    button: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    caption: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    titleSpacing: 20,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    color: HexColor('3c3f41'),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('3c3f41'),
      statusBarBrightness: Brightness.dark,
    ),
  ),
  scaffoldBackgroundColor: HexColor('3c3f41'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('3c3f41'),
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: const TextStyle(
      color: Colors.grey,
    ),
    elevation: 50,
  ),
);
