import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tick_done_app/firebase_utils/firebase_utils.dart';
import 'package:tick_done_app/model/task_model.dart';
import 'package:tick_done_app/theming/app_colors.dart';

import '../providers/app_config_provider.dart';
import '../providers/auth_user_provider.dart';
import '../providers/tasks_provider.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = "edit_task_screen";

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  var selectedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();

  late AppConfigProvider provider;
  late AuthUserProvider userProvider;
  late TasksProvider tasksProvider;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  Task? task;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(task == null){
      Task taskArgs = ModalRoute.of(context)?.settings.arguments as Task;
      task = taskArgs;
      titleController.text = task!.title;
      descController.text = task!.description;
      selectedDate = task!.dateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    userProvider = Provider.of<AuthUserProvider>(context);
    tasksProvider = Provider.of<TasksProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "TickDone",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  AppLocalizations.of(context)!.edit_task,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                AppLocalizations.of(context)!.title,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "Please enter a task title";
                  }
                  return null;
                },
                controller: titleController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enter_title,
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          width: 2, color: AppColors.primaryLightColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          width: 2, color: AppColors.primaryLightColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          width: 2, color: AppColors.primaryLightColor)),
                ),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                AppLocalizations.of(context)!.description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "Please enter a task description";
                  }
                  return null;
                },
                controller: descController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enter_description,
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          width: 2, color: AppColors.primaryLightColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          width: 2, color: AppColors.primaryLightColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                          width: 2, color: AppColors.primaryLightColor)),
                ),
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 5,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                AppLocalizations.of(context)!.date,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: showCalender,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.primaryLightColor, width: 1.5),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('EEE, dd MMM, yyyy').format(selectedDate),
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.darkTextColor,
                                ),
                      ),
                      Icon(Icons.calendar_month,
                          color: AppColors.primaryLightColor),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    saveChanges();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.save_changes,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppColors.whiteColor),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 28),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: AppColors.textButtonColor),
                ),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      AppColors.primaryLightColor.withOpacity(0.1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: AppColors.whiteColor,
                  onSurface: AppColors.darkTextColor,
                ),
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        foregroundColor: AppColors.textButtonColor)),
              ),
              child: child!);
        });
    selectedDate = chosenDate ?? selectedDate;
    setState(() {});
  }

  void saveChanges() {
    if (formKey.currentState!.validate() == true) {
      // add this task
      Task updatedTask = Task(
          id: task!.id,
          title: titleController.text,
          description: descController.text,
          dateTime: selectedDate);

      FirebaseUtils.updateTaskInFireStore(updatedTask , userProvider.currentUser!.id!)
          .then((value) {
        print("Task edited successfully");
        tasksProvider.refreshTasksAfterFilter(userProvider.currentUser!.id!);
        Navigator.pop(context);
      })
          .timeout(Duration(seconds: 1),
          onTimeout: () {
        print("Task edited successfully");
        tasksProvider.refreshTasksAfterFilter(userProvider.currentUser!.id!);
        Navigator.pop(context);
      });
    }
  }
}
