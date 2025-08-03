import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils/firebase_utils.dart';
import '../model/task_model.dart';

class TasksProvider extends ChangeNotifier{
  List<Task> tasks = [];
  DateTime selectedDate = DateTime.now();
  List<Task> allUserTasks = [];
  String chosenFilter = "all";
  void getAllTasksFromFireStore(String uId) async{
    chosenFilter = "all";
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
    chosenFilter = "completed";
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
    chosenFilter = "pending";
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
  void getAllUserTasksFromFireStore(String uId) async{
    QuerySnapshot<Task> snapshot = await FirebaseUtils.getTasksCollections(uId).get();
    //List<QueryDocumentSnapshot<Task>>   =>   List<Task>
    List<Task> tasksList = snapshot.docs.map((doc){
      return doc.data();
    }).toList();
    allUserTasks = tasksList;
    notifyListeners();
  }

  int completedTasksCount(String uId){
    return allUserTasks.where((task) => task.isDone == true).length;
  }

  int pendingTasksCount(String uId){
    return
      allUserTasks.where((task) => task.isDone == false).length;
  }

  int allTasksCount(String uId){
    return allUserTasks.length;
  }

  void refreshTasksAfterFilter(String uId) {
    switch (chosenFilter) {
      case 'completed':
         filterCompletedTasks(uId);
        break;
      case 'pending':
         filterPendingTasks(uId);
        break;
      case 'all':
      default:
         getAllTasksFromFireStore(uId);
        break;
    }
  }


}