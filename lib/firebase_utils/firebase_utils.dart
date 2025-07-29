import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tick_done_app/model/task_model.dart';

class FirebaseUtils{

  static CollectionReference<Task> getTasksCollections(){
    return FirebaseFirestore.instance.collection(Task.collectionName).
    withConverter<Task>(
        fromFirestore: (snapshot , options) => Task.fromFireStore(snapshot.data()!),
        toFirestore: (task,options) =>task.toFireStore()
    );
  }

  static Future<void> addTaskToFireStore(Task task){
    var collectionRef = getTasksCollections();   // get collection
    var documentRef = collectionRef.doc();       // create document
    task.id = documentRef.id;                    // pass Auto_Id to id of task
    return documentRef.set(task);
  }


  static Future<void> deleteTaskFromFireStore(Task task){
    return getTasksCollections().doc(task.id).delete();

  }
  static Future<void> updateTaskInFireStore(Task task){
    return getTasksCollections().doc(task.id).update(task.toFireStore());
  }

  static Future<void> completeTaskInFireStore(Task task){
    task.isDone = true;
    return getTasksCollections().doc(task.id).update(task.toFireStore());
  }





}