import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tick_done_app/providers/app_config_provider.dart';
import 'package:tick_done_app/tasks/task_item.dart';
import 'package:tick_done_app/theming/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
 late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    if(provider.tasks.isEmpty){
      provider.getAllTasksFromFireStore();
    }
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: provider.selectedDate,
          onDateChange: (selectedDate) {
            provider.changeDateTime(selectedDate);
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.dropDown,
            dateFormatter: DateFormatter.fullDateDMonthAsStrY(),
          ),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNumMonth,
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
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
          ),
        ),

        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.all_tasks ,
              style: Theme.of(context).textTheme.bodyMedium,),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.filter_list_off_sharp, size: 28, color: AppColors.primaryLightColor,),
              ),
            ],
          ),

        ),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context , index){
               return TaskItem(task: provider.tasks[index]);
              },
            itemCount: provider.tasks.length,
          ),
        )
      ],

    );
  }


}
