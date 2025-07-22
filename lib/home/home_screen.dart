import 'package:flutter/material.dart';
import 'package:tick_done_app/new_task/add_new_task_screen.dart';
import 'package:tick_done_app/settings/settings_tab.dart';
import 'package:tick_done_app/tasks/tasks_tab.dart';
import 'package:tick_done_app/theming/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TickDone" ,
        style: Theme.of(context).textTheme.bodyLarge,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed(NewTaskScreen.routeName);
        },
        child: Icon(Icons.add , size: 25 ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        color: AppColors.primaryLightColor,
        child: BottomNavigationBar(

          onTap: (index){
            selectedIndex = index;
            setState(() {

            });
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_sharp , size: 28),
              label:AppLocalizations.of(context)?.home,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings , size: 28),
              label: AppLocalizations.of(context)?.settings,
            ),

          ],
        ),
      ),

      body: selectedIndex == 0 ? TasksTab() : SettingsTab()
    );
  }
}
