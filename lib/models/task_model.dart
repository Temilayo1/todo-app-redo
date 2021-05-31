import 'package:flutter/foundation.dart';

final String tasks = 'tasks';

class TaskFields {
  static final List<String> values = [
    id,
    isImportant,
    number,
    title,
    description,
    time
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class TaskModel {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  TaskModel({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });
  TaskModel copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      TaskModel(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        title: title ?? this.title,
        description: description ?? this.description,
        number: number ?? this.number,
        createdTime: createdTime ?? this.createdTime,
      );

  static TaskModel fromJson(Map<String, Object?> json) => TaskModel(
        id: json[TaskFields.id] as int?,
        isImportant: json[TaskFields.isImportant] == 1,
        number: json[TaskFields.number] as int,
        title: json[TaskFields.title] as String,
        description: json[TaskFields.description] as String,
        createdTime: DateTime.parse(json[TaskFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        TaskFields.id: id,
        TaskFields.title: title,
        TaskFields.description: description,
        TaskFields.isImportant: isImportant ? 1 : 0,
        TaskFields.time: createdTime.toIso8601String(),
        TaskFields.number: number,
      };
}
