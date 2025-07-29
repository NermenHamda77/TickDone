import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils/firebase_utils.dart';
import '../model/task_model.dart';

class AppConfigProvider extends ChangeNotifier{
  String appLanguage = "en";
  ThemeMode appMode = ThemeMode.light;
  List<Task> tasks = [];
  DateTime selectedDate = DateTime.now();

  void changeAppLanguage(String newLanguage){
    if(appLanguage == newLanguage){
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  void changeAppMode(ThemeMode newMode){
    if(appMode == newMode){
      return;
    }
    appMode = newMode;
    notifyListeners();
  }

  bool isDarkMode(){
    return appMode == ThemeMode.dark;
  }

  bool isEnglishLanguage(){
    return appLanguage == "en";
  }

  void getAllTasksFromFireStore() async{
    QuerySnapshot<Task> snapshot = await FirebaseUtils.getTasksCollections().get();
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

  void changeDateTime(DateTime newSelectedDate){
    selectedDate = newSelectedDate;
    getAllTasksFromFireStore();
  }
}