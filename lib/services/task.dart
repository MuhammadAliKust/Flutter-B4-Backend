import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b4/models/task.dart';

class TaskServices {
  ///Create Task
  Future createTask(TaskModel model) async {
    await FirebaseFirestore.instance
        .collection('taskCollection')
        .add(model.toJson());
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
  ///Get All Tasks
  ///Get InCompleted Tasks
}
