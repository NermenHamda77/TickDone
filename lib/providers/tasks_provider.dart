import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils/firebase_utils.dart';
import '../model/task_model.dart';

class TasksProvider extends ChangeNotifier{
  List<Task> tasks = [];
  DateTime selectedDate = DateTime.now();

  void getAllTasksFromFireStore(String uId) async{
    QuerySnapshot<Task> snapshot = await FirebaseUtils.getTasksCollections(uId).get();
    //List<QueryDocumentSnapshot<Task>>   =>   List<Task>
    List<Task> tasksList = snapshot.docs.map((doc){
      return doc.data();
    }).toList();
    tasksList = tasksList.where((task) {
      if(task.dateTime.day == selectedDate.day &&
          task.dateTime.month == selectedDate.month &&
          task.dateTime.year == selectedDate.year
      ){
        return true;
      }
      return false;
    }).toList();

    tasksList.sort((Task task1 , Task task2){
      return task1.dateTime.compareTo(task2.dateTime);
    });
    tasks = tasksList;
    notifyListeners();
  }

  void changeDateTime(DateTime newSelectedDate , String uId){
    selectedDate = newSelectedDate;
    getAllTasksFromFireStore(uId);
  }

  void filterCompletedTasks(String uId) async{
    QuerySnapshot<Task>  snapshot = await FirebaseUtils.getTasksCollections(uId).get();
    List<Task> tasksList = snapshot.docs.map((doc){
      return doc.data();
    }).toList();


    tasksList = tasksList.where((task) {
      return task.dateTime.day == selectedDate.day &&
          task.dateTime.month == selectedDate.month &&
          task.dateTime.year == selectedDate.year &&
          task.isDone == true ;

    }).toList();

    tasksList.sort((Task task1 , Task task2){
      return task1.dateTime.compareTo(task2.dateTime);
    });
    tasks = tasksList;
    notifyListeners();

  }
  void filterPendingTasks(String uId) async{
    QuerySnapshot<Task>  snapshot = await FirebaseUtils.getTasksCollections(uId).get();
    List<Task> tasksList = snapshot.docs.map((doc){
      return doc.data();
    }).toList();


    tasksList = tasksList.where((task) {
      return task.dateTime.day == selectedDate.day &&
          task.dateTime.month == selectedDate.month &&
          task.dateTime.year == selectedDate.year &&
          task.isDone == false ;

    }).toList();

    tasksList.sort((Task task1 , Task task2){
      return task1.dateTime.compareTo(task2.dateTime);
    });
    tasks = tasksList;
    notifyListeners();

  }
}