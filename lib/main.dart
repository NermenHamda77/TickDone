import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tick_done_app/authentication/signUpScreen.dart';
import 'package:tick_done_app/edit_task/edit_task_screen.dart';
import 'package:tick_done_app/home/home_screen.dart';
import 'package:tick_done_app/new_task/add_new_task_screen.dart';
import 'package:tick_done_app/profile/change_password_screen.dart';
import 'package:tick_done_app/providers/app_config_provider.dart';
import 'package:tick_done_app/providers/auth_user_provider.dart';
import 'package:tick_done_app/providers/tasks_provider.dart';
import 'package:tick_done_app/theming/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'authentication/loginScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ?
     await Firebase.initializeApp(
       options: FirebaseOptions(
           apiKey: 'AIzaSyAU-X3Q3pAxlabMrum9bp_CVKIXmUsxSmM',
           appId: 'com.example.tick_done_app',
           messagingSenderId: '948642296882',
           projectId: 'tick-done-app'
       )

     ) : await Firebase.initializeApp();
  //FirebaseFirestore.instance.disableNetwork();  // offline
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppConfigProvider(),),
        ChangeNotifierProvider(create: (context) => AuthUserProvider(),),
        ChangeNotifierProvider(create: (context) => TasksProvider(),),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    loadSharedPrefsData(provider);
    return MaterialApp(
      theme: MyTheme.lightTheme,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        NewTaskScreen.routeName: (context) => NewTaskScreen(),
        EditTaskScreen.routeName: (context) => EditTaskScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),

      },
      themeMode: provider.appMode,
      darkTheme: MyTheme.darkTheme,
      initialRoute: SignUpScreen.routeName,
      locale: Locale(provider.appLanguage),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  void loadSharedPrefsData(AppConfigProvider provider) async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var mode = sharedPreferences.get("isDarkMode");
    if(mode == true){
      provider.changeAppMode(ThemeMode.dark);
    }else if(mode == false){
      provider.changeAppMode(ThemeMode.light);
    }

    var language = sharedPreferences.get("isEnglishLanguage");
    if(language == true){
      provider.changeAppLanguage("en");
    }else if(language == false){
      provider.changeAppLanguage("ar");
    }
  }

}
