import 'package:bandoan/theme/dark.dart';
import 'package:bandoan/theme/light.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightmode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode  => _themeData == darkmode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleThemeData(){
    if(_themeData == lightmode){
      themeData = darkmode;
    }else {
      themeData = lightmode;
    }
  }
}