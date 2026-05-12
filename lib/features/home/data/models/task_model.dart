import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? id;
  String title;
  String description;
  bool isCompleted;
  DateTime createdAt;
  DateTime updatedAt;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TaskModel(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    isCompleted: isCompleted ?? this.isCompleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory TaskModel.fromJson(Map<String, dynamic> json, String id) => TaskModel(
    id: id,
    title: json["title"] ?? "",
    description: json["description"] ?? "",
    isCompleted: json["isCompleted"] ?? false,
    createdAt: (json["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
    updatedAt: (json["updatedAt"] as Timestamp?)?.toDate() ?? DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "isCompleted": isCompleted,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}
