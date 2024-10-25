import 'package:flutter/material.dart';

final appTheme = {
  'black': ThemeData(
      useMaterial3: true,
      primaryColor: const Color(0xFF000000),
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.red,
      textTheme: const TextTheme(
          bodySmall: TextStyle(fontSize: 24, color: Colors.white))),
  'pink': ThemeData(
      useMaterial3: true,
      primaryColor: Colors.pink,
      brightness: Brightness.light,
      textTheme: const TextTheme(
          bodySmall: TextStyle(fontSize: 24, color: Colors.black))),
  'red': ThemeData(
      useMaterial3: true,
      primaryColor: Colors.red,
      brightness: Brightness.light,
      textTheme: const TextTheme(
          bodySmall: TextStyle(fontSize: 24, color: Colors.red))),
  'blue': ThemeData(
      useMaterial3: true,
      primaryColor: Colors.blue,
      brightness: Brightness.light,
      textTheme: const TextTheme(
          bodySmall: TextStyle(fontSize: 24, color: Colors.red))),
  'green': ThemeData(
      useMaterial3: true,
      primaryColor: Colors.green,
      brightness: Brightness.light,
      textTheme: const TextTheme(
          bodySmall: TextStyle(fontSize: 24, color: Colors.red))),
  'gray': ThemeData(
      useMaterial3: true,
      primaryColor: Colors.grey,
      brightness: Brightness.dark,
      textTheme: const TextTheme(
          bodySmall: TextStyle(fontSize: 24, color: Colors.red))),
};
