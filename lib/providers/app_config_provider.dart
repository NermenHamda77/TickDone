import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppConfigProvider extends ChangeNotifier{
  String appLanguage = "en";
  ThemeMode appMode = ThemeMode.light;
 // bool notificationsEnabled = false;

  void changeAppLanguage(String newLanguage) async{
    if(appLanguage == newLanguage){
      return;
    }
    appLanguage = newLanguage;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isEnglishLanguage", isEnglishLanguage());
    notifyListeners();

  }

  void changeAppMode(ThemeMode newMode) async{
    if(appMode == newMode){
      return;
    }
    appMode = newMode;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isDarkMode", isDarkMode());
    notifyListeners();

  }

  bool isDarkMode(){
    return appMode == ThemeMode.dark;
  }

  bool isEnglishLanguage(){
    return appLanguage == "en";
  }

/*  bool isNotificationsEnabled(){
    return notificationsEnabled;
  }

  Future<void> setNotificationsEnabled(bool value) async{
    notificationsEnabled = value;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isNotificationsEnabled", isNotificationsEnabled());
    notifyListeners();
  }
  */
}