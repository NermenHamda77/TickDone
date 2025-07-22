import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:tick_done_app/tasks/task_item.dart';
import 'package:tick_done_app/theming/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
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
               return TaskItem(taskTitle: "title1", taskDesc: "description1",);
              },
            itemCount: 10,
          ),
        )
      ],

    );
  }
}
