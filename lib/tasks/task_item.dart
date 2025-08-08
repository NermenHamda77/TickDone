import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tick_done_app/edit_task/edit_task_screen.dart';
import 'package:tick_done_app/firebase_utils/firebase_utils.dart';
import 'package:tick_done_app/model/task_model.dart';
import 'package:tick_done_app/providers/auth_user_provider.dart';
import 'package:tick_done_app/providers/tasks_provider.dart';
import 'package:tick_done_app/theming/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../providers/app_config_provider.dart';

class TaskItem extends StatefulWidget {
  Task task;

  TaskItem({required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late AppConfigProvider provider;
  late AuthUserProvider userProvider;
  late TasksProvider tasksProvider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    userProvider = Provider.of<AuthUserProvider>(context);
    tasksProvider = Provider.of<TasksProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: widget.task.isDone == true
            ? Theme.of(context).primaryColor
            : provider.isDarkMode()
                ? AppColors.blackColor
                : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
            color: widget.task.isDone == true
                ? Colors.transparent
                : Theme.of(context).primaryColor,
            width: 2),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: widget.task.isDone == true
                      ? AppColors.blackColor
                      : provider.isDarkMode()
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.task.description,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: widget.task.isDone == true
                      ? AppColors.whiteColor
                      : provider.isDarkMode()
                      ? AppColors.beigeColor
                      : AppColors.secondaryTextColor,
                ),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditTaskScreen.routeName, arguments: widget.task);
            },
            icon: Icon(
              Icons.edit_note,
              size: 28,
            ),
            color: widget.task.isDone == true
                ? AppColors.lightBeigeColor
                : provider.isDarkMode()
                ? AppColors.primaryDarkColor
                : AppColors.primaryLightColor,

          ),
          IconButton(
            onPressed: () {
              FirebaseUtils.completeTaskInFireStore(
                      widget.task, userProvider.currentUser!.id!)
                  .then((value) {
                setState(() {
                  tasksProvider
                      .refreshTasksAfterFilter(userProvider.currentUser!.id!);
                  tasksProvider.getAllUserTasksFromFireStore(
                      userProvider.currentUser!.id!);
                });
              }).timeout(Duration(seconds: 1), onTimeout: () {
                tasksProvider
                    .refreshTasksAfterFilter(userProvider.currentUser!.id!);
                print(
                  AppLocalizations.of(context)!.tasks_completed_successfully,
                );
              });
            },
            icon: widget.task.isDone == true
                ? Icon(
                    Icons.check_circle,
                    size: 28,
                  )
                : Icon(
                    Icons.check_circle_outline_sharp,
                    size: 28,
                  ),
            color: widget.task.isDone == true
                ? AppColors.lightBeigeColor
                : provider.isDarkMode()
                ? AppColors.primaryDarkColor
                : AppColors.primaryLightColor,
          ),
          IconButton(
            onPressed: () {
              showConfirmDialog();
            },
            icon: Icon(
              Icons.delete_outline_outlined,
              size: 28,
            ),
            color:widget.task.isDone == true
                ? AppColors.lightBeigeColor
                : provider.isDarkMode()
                ? AppColors.primaryDarkColor
                : AppColors.primaryLightColor,
          ),
        ],
      ),
    );
  }

  void showConfirmDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.confirm_delete_title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.blackColor),
        ),
        content: Text(
          AppLocalizations.of(context)!.confirm_delete_message,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: AppColors.secondaryTextColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel,
                style: TextStyle(color: AppColors.beigeColor)),
          ),
          TextButton(
            onPressed: () {
              // delete task
              FirebaseUtils.deleteTaskFromFireStore(
                      widget.task, userProvider.currentUser!.id!)
                  .then((value) {
                tasksProvider
                    .refreshTasksAfterFilter(userProvider.currentUser!.id!);
                tasksProvider.getAllUserTasksFromFireStore(
                    userProvider.currentUser!.id!);
              }).timeout(Duration(seconds: 1), onTimeout: () {
                print(
                    AppLocalizations.of(context)!.task_is_deleted_successfully);
              });
              Navigator.pop(context);
              tasksProvider
                  .refreshTasksAfterFilter(userProvider.currentUser!.id!);
            },
            child: Text(AppLocalizations.of(context)!.delete,
                style: TextStyle(color: Theme.of(context).primaryColor)),
          ),
        ],
      ),
    );
  }
}
