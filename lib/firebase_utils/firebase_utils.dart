import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tick_done_app/model/my_user.dart';
import 'package:tick_done_app/model/task_model.dart';

class FirebaseUtils{

  static CollectionReference<Task> getTasksCollections(String uId){
    return
      getUsersCollection().doc(uId)
          .collection(Task.collectionName).withConverter<Task>(
        fromFirestore: (snapshot , options) => Task.fromFireStore(snapshot.data()!),
        toFirestore: (task,options) =>task.toFireStore()
    );
  }

  static Future<void> addTaskToFireStore(Task task , String uId){
    var collectionRef = getTasksCollections(uId);
    var documentRef = collectionRef.doc();
    task.id = documentRef.id;
    return documentRef.set(task);
  }


  static Future<void> deleteTaskFromFireStore(Task task , String uId){
    return getTasksCollections(uId).doc(task.id).delete();

  }
  static Future<void> updateTaskInFireStore(Task task , String uId){
    return getTasksCollections(uId).doc(task.id).update(task.toFireStore());
  }

  static Future<void> completeTaskInFireStore(Task task , String uId){
    task.isDone = true;
    return getTasksCollections(uId).doc(task.id).update(task.toFireStore());
  }
  static CollectionReference<MyUser> getUsersCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
        fromFirestore: (snapshot , option) => MyUser.fromFireStore(snapshot.data()!),
        toFirestore: (myUser , option) => myUser.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser myUser){
   return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> getUserFromFireStore(String uId) async{
    var querySnapshot = await getUsersCollection().doc(uId).get();
    return querySnapshot.data();

  }


}