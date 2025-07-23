import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tick_done_app/home/home_screen.dart';
import 'package:tick_done_app/new_task/add_new_task_screen.dart';
import 'package:tick_done_app/providers/app_config_provider.dart';
import 'package:tick_done_app/theming/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => AppConfigProvider(),
        child: const MyApp()
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      theme: MyTheme.lightTheme,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        NewTaskScreen.routeName: (context) => NewTaskScreen(),

      },
      themeMode: provider.appMode,

      initialRoute: HomeScreen.routeName,
      locale: Locale(provider.appLanguage),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
