// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) =>
    json.encode(data.toJson(data.docId.toString()));

class TaskModel {
  TaskModel({
    this.docId,
    this.taskTitle,
    this.description,
    this.isCompleted,
  });

  String? docId;
  String? taskTitle;
  String? description;
  bool? isCompleted;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        docId: json["docId"],
        taskTitle: json["taskTitle"],
        description: json["description"],
        isCompleted: json["isCompleted"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "docId": docID,
        "taskTitle": taskTitle,
        "description": description,
        "isCompleted": false,
      };
}
