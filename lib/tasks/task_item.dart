import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  String taskTitle;
  String taskDesc;
  TaskItem({required this.taskTitle , required this.taskDesc});

  @override
  Widget build(BuildContext context) {
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
              Text(taskTitle ,
              style: Theme.of(context).textTheme.bodySmall,),
              SizedBox(height: 10,),
              Text(taskDesc,
                style: Theme.of(context).textTheme.titleLarge,),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.edit_note, size: 28,),
            color: Theme.of(context).primaryColor,
          ),


          IconButton(
            onPressed: (){},
            icon: Icon(Icons.check_circle_outline_sharp, size: 28,),
            color: Theme.of(context).primaryColor,
          ),

          IconButton(
            onPressed: (){},
            icon: Icon(Icons.cancel_outlined, size: 28,),
            color: Theme.of(context).primaryColor,
          ),

        ],
      ),
    );
  }
}
