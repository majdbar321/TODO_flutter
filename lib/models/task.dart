import 'package:flutter/material.dart';

//Marcell - good idea of using a different file for the tasks so they can be accessed from different file without needing to access
//unsued classes

//Marcell - DateTime would be sufficent enough as it can store hours and minutes too and therefore the TimeOfDay is not really needed
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
