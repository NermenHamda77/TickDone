import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tick_done_app/edit_task/edit_task_screen.dart';
import 'package:tick_done_app/firebase_utils/firebase_utils.dart';
import 'package:tick_done_app/model/task_model.dart';
import 'package:tick_done_app/providers/auth_user_provider.dart';
import 'package:tick_done_app/providers/tasks_provider.dart';

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
      margin: EdgeInsets.symmetric(vertical: 5 , horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2
        ),

      ),

      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.task.title ,
              style: Theme.of(context).textTheme.bodySmall,),
              SizedBox(height: 10,),
              Text(widget.task.description,
                style: Theme.of(context).textTheme.titleLarge,),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: (){
              Navigator.of(context).pushNamed(EditTaskScreen.routeName ,
                  arguments: widget.task);
              },
            icon: Icon(Icons.edit_note, size: 28,),
            color: Theme.of(context).primaryColor,
          ),


          IconButton(
            onPressed: (){
              FirebaseUtils.completeTaskInFireStore(widget.task , userProvider.currentUser!.id!)
                  .then((value){
                setState(() {
                  tasksProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
                  tasksProvider.getAllUserTasksFromFireStore(userProvider.currentUser!.id!);

                });
              })
                  .timeout(
                Duration(seconds: 1), onTimeout: (){
                tasksProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
                print("Task is completed successfully");
              }
              );



            },
            icon: widget.task.isDone == true ?
            Icon(Icons.check_circle_outline_sharp, size: 28,color: Color(
                0x9DE6F589),):
            Icon(Icons.check_circle_outline_sharp, size: 28,),
            color: Theme.of(context).primaryColor,
          ),

          IconButton(
            onPressed: (){
              FirebaseUtils.deleteTaskFromFireStore(widget.task , userProvider.currentUser!.id!)
                  .then((value){
                tasksProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
                tasksProvider.getAllUserTasksFromFireStore(userProvider.currentUser!.id!);


              })
                  .timeout(
                  Duration(seconds: 1) , onTimeout: (){
                    print("Task is deleted successfully");
              });
              tasksProvider.getAllTasksFromFireStore(userProvider.currentUser!.id!);

            },
            icon: Icon(Icons.cancel_outlined, size: 28,),
            color: Theme.of(context).primaryColor,
          ),

        ],
      ),
    );
  }
}
