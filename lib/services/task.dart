import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_b4/models/task.dart';

class TaskServices {
  ///Create Task
  Future createTask(TaskModel model) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('taskCollection').doc();
    await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }

  ///Update Task
  Future updateTask(TaskModel model) async {
    await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({
      "title": model.title,
      "description": model.description,
    });
  }

  ///Delete Task
  Future deleteTask(String taskID) async {
    await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .delete();
  }

  ///Mark Task As Complete
  Future markTaskAsComplete(String taskID) async {
    await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .update({'isCompleted': true});
  }

  ///Get Completed Task
  Stream<List<TaskModel>> getCompletedTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((taskModel) => TaskModel.fromJson(taskModel.data()))
            .toList());
  }

  ///Get All Tasks
  Stream<List<TaskModel>> getAllTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((taskModel) => TaskModel.fromJson(taskModel.data()))
            .toList());
  }

  ///Get InCompleted Tasks
  Stream<List<TaskModel>> getInCompletedTasks() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map((taskList) => taskList.docs
            .map((taskModel) => TaskModel.fromJson(taskModel.data()))
            .toList());
  }
}
