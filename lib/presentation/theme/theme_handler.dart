import 'package:flutter/material.dart';

class ThemeHandler{
  final darkTheme = ThemeData(
    fontFamily: "Cairo",
    // primaryColor: Color(0xff794de2),
    backgroundColor: Color(0xff313660),
    scaffoldBackgroundColor: Color(0xff414670),
    hintColor: Color(0xff636a9a),
    primaryColorDark: Color(0xff794de2),
    primaryColorLight: Color(0xff36a1d4),
    highlightColor: Color(0xffe6e8f7),
    canvasColor: Color(0xff282e55),
    cardColor: Color(0xff464f87),
    textTheme: TextTheme().apply(
      displayColor: Color(0xffe6e8f7),
      bodyColor: Color(0xffe6e8f7),
    ),
  );
  final lightTheme = ThemeData(
    fontFamily: "Cairo",

  );
}