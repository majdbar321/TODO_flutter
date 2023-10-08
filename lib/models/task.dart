import 'package:flutter/material.dart';

class Task {
  String title;
  String description;
  DateTime dueDate;
  TimeOfDay dueTime;
  bool isComplete;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.dueTime,
    this.isComplete = false,
  });
}
