import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tick_done_app/providers/app_config_provider.dart';
import 'package:tick_done_app/tasks/task_item.dart';
import 'package:tick_done_app/theming/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/auth_user_provider.dart';
import '../providers/tasks_provider.dart';


class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
 late AppConfigProvider provider;
 var menuKey = GlobalKey();
 String chosenOption = '';
 late AuthUserProvider userProvider;
 late TasksProvider tasksProvider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    userProvider = Provider.of<AuthUserProvider>(context);
    tasksProvider = Provider.of<TasksProvider>(context);

    if(tasksProvider.tasks.isEmpty){
      tasksProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
    }
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: tasksProvider.selectedDate,
          onDateChange: (selectedDate) {
            tasksProvider.changeDateTime(selectedDate , userProvider.currentUser!.id!);
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.dropDown,
            dateFormatter: DateFormatter.fullDateDMonthAsStrY(),
          ),
          dayProps: const EasyDayProps(

            dayStructure: DayStructure.dayStrDayNumMonth,
            activeDayStyle: DayStyle(
              /*dayNumStyle: TextStyle(
                color: Colors.red,
              ),
              dayStrStyle: TextStyle(
                color: Colors.deepPurple,
              ),
              monthStrStyle:  TextStyle(
                color: Colors.blue,
              ),*/
              decoration: BoxDecoration(
               // color: ,  // color of day number
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryLightColor,
                    AppColors.primaryLightColor,
                  ],
                ),
              ),
            ),
/*
            inactiveDayStyle: DayStyle(
              dayNumStyle: TextStyle(
                color: Colors.orange,
              ),
              dayStrStyle: TextStyle(
                color: Colors.yellow,
              ),
              monthStrStyle:  TextStyle(
                color: Colors.green,
              ),
            )
*/
          ),


        ),

        SizedBox(height: 10,),
        Divider(
          thickness: 1,
          color: AppColors.lightBeigeColor,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                chosenOption.trim().isEmpty ?
                AppLocalizations.of(context)!.all_tasks :
                chosenOption,
              style: Theme.of(context).textTheme.bodyMedium,),
              IconButton(
                key: menuKey,
                onPressed: (){
                  /// Filter Tasks => All Tasks , Completed Tasks , Pending Tasks
                  showFilterMenu();
                },
                icon: Icon(Icons.filter_list, size: 28, color: AppColors.primaryLightColor,),
              ),
            ],
          ),

        ),
        Divider(
          thickness: 2,
          color: AppColors.lightBeigeColor,
        ),
        SizedBox(height: 10,),

        Expanded(
          child: ListView.builder(
              itemBuilder: (context , index){
               return TaskItem(task: tasksProvider.tasks[index]);
              },
            itemCount: tasksProvider.tasks.length,
          ),
        )
      ],

    );
  }

  showFilterMenu(){
    final RenderBox button = menuKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset position = button.localToGlobal(Offset.zero , ancestor: overlay);
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
            position.dx,
            position.dx + button.size.height,
            position.dx + button.size.width,
            0),
        items: [
          PopupMenuItem(
              child:TextButton(
                onPressed: (){
                  // show all tasks
                  setState(() {
                    tasksProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
                    chosenOption = AppLocalizations.of(context)!.all_tasks;
                    Navigator.pop(context);
                  });

                },
                child: Text(AppLocalizations.of(context)!.all_tasks,
                  style: Theme.of(context).textTheme.titleLarge,),
              )
          ),
          PopupMenuItem(
              child:TextButton(
                onPressed: (){
                  // show pending tasks
                  setState(() {
                    tasksProvider.filterPendingTasks(userProvider.currentUser!.id!);
                    chosenOption = AppLocalizations.of(context)!.pending_tasks;
                    Navigator.pop(context);

                  });
                },
                child: Text(AppLocalizations.of(context)!.pending_tasks,
                  style: Theme.of(context).textTheme.titleLarge,),
              )
          ),
          PopupMenuItem(
              child:TextButton(
                onPressed: (){
                  // show completed tasks
                  setState(() {
                    tasksProvider.filterCompletedTasks(userProvider.currentUser!.id!);
                    chosenOption = AppLocalizations.of(context)!.completed_tasks;
                    Navigator.pop(context);
                  });

                },
                child: Text(AppLocalizations.of(context)!.completed_tasks ,
                style: Theme.of(context).textTheme.titleLarge,),
              )
          ),
        ]);

  }


}
