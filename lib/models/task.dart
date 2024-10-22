// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) =>
    json.encode(data.toJson(data.docId.toString()));

class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final String? userID;
  final String? image;
  final bool? isCompleted;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.isCompleted,
    this.image,
    this.userID,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        docId: json["docID"],
        title: json["title"],
        description: json["description"],
        isCompleted: json["isCompleted"],
    image: json["image"],
        userID: json["userID"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson(String taskID) => {
        "docID": taskID,
        "title": title,
        "description": description,
        "image": image,
        "isCompleted": isCompleted,
        "userID": userID,
        "createdAt": createdAt,
      };
}
