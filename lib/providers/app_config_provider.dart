import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier{
  String appLanguage = "en";
  ThemeMode appMode = ThemeMode.dark;

  void changeAppLanguage(String newLanguage){
    if(appLanguage == newLanguage){
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  void changeAppMode(ThemeMode newMode){
    if(appMode == newMode){
      return;
    }
    appMode = newMode;
    notifyListeners();
  }

  bool isDarkMode(){
    return appMode == ThemeMode.dark;
  }

  bool isEnglishLanguage(){
    return appLanguage == "en";
  }
}