import 'package:flutter/material.dart';
import '../../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> _completedTasks = [];

  List<Task> get tasks => _tasks;
  List<Task> get completedTasks => _completedTasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void completeTask(int index) {
    _tasks[index].isComplete = true;
    _completedTasks.add(_tasks[index]);
    _tasks.removeAt(index);
    notifyListeners();
  }

  void uncompleteTask(int index) {
    _completedTasks[index].isComplete = false;
    _tasks.add(_completedTasks[index]);
    _completedTasks.removeAt(index);
    notifyListeners();
  }

  void updateTask(int index, Task task) {
    _tasks[index] = task;
    notifyListeners();
  }

  void updateTaskcomplete(int index, Task task) {
    _completedTasks[index] = task;
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
