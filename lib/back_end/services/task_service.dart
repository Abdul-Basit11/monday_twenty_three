import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monday_twenty_three/back_end/model/task_model.dart';

class TaskServices {
  ///create Task
  Future createTask(TaskModel taskModel) async {
    DocumentReference _docRef =
        FirebaseFirestore.instance.collection('taskCollection').doc();

    return await _docRef.set(taskModel.toJson(_docRef.id));
  }

  ///Display All Task
  Stream<List<TaskModel>> fetchAllTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .snapshots()
        .map((docList) => docList.docs
            .map((singleDoc) => TaskModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///Delete Task
  Future deleteTask(String taskId) async {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskId)
        .delete();
  }

  /// Diaplay completed task

  Stream<List<TaskModel>> fetchCompletedTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map((docsList) => docsList.docs
            .map((singleDoc) => TaskModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///Display Incompleted Task
  Stream<List<TaskModel>> fetchIncompleteTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map((docsList) => docsList.docs
            .map((singleDoc) => TaskModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///Update Task TO Completed
  Future updateTask(TaskModel taskModel) async {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskModel.docId)
        .update({
      'taskTitle': taskModel.taskTitle,
      'description': taskModel.description,
    });
  }




  ///Display task Details ...
  Stream<TaskModel> fetchSpecificDetails(String taskId) {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskId)
        .snapshots()
        .map((singleTask) => TaskModel.fromJson(singleTask.data()!));
  }

  ///Marl Task As Completed.....
  Future markTaskAsCompleted(String taskID) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .update({
      'isCompleted': true,
    });
  }





}
