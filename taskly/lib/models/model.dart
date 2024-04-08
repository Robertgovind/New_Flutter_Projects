import 'package:flutter/material.dart';

class Task {
  String taskTitle;
  DateTime taskTime;
  bool isDone;

  Task({
    required this.taskTitle,
    required this.taskTime,
    required this.isDone,
  });

  factory Task.fromMap(Map task) {
    return Task(
      taskTitle: task["taskTitle"],
      taskTime: task["taskTime"],
      isDone: task["isDone"],
    );
  }

  Map toMap() {
    return {
      "taskTitle": taskTitle,
      "taskTime": taskTime,
      "isDone": isDone,
    };
  }
}
