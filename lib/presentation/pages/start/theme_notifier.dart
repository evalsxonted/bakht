import 'package:bakht/presentation/theme/theme_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier{
  ThemeData? _themeData;

  ThemeData? get themeData => _themeData;


  Future<ThemeNotifier> initTheme() async {
    _themeData = ThemeHandler().darkTheme;
    return this;
  }

  switchToDark(){
    notifyListeners();
  }
  switchToLight(){
    notifyListeners();
  }
}