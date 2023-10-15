import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/edit_tasks_screen.dart';
//Marcell - lack of comments explaining the code

class TaskDetailScreen extends StatelessWidget {
  final Task task;
  final int taskIndex;

  TaskDetailScreen({required this.task, required this.taskIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
        backgroundColor: task.isComplete ? Colors.green : Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false)
                  .removeTask(task);

              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: task.isComplete ? Colors.green : Colors.deepPurple),
            ),
            SizedBox(height: 10),
            Text(
              task.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Due: ${task.dueDate.toLocal()}',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (task.isComplete) {
                  Provider.of<TaskProvider>(context, listen: false)
                      .uncompleteTask(taskIndex);
                } else {
                  Provider.of<TaskProvider>(context, listen: false)
                      .completeTask(taskIndex);
                }
                Navigator.pop(context);
              },
              child: Text(
                  task.isComplete ? 'Mark as Incomplete' : 'Mark as Complete'),
              style: ElevatedButton.styleFrom(
                primary: task.isComplete ? Colors.deepPurple : Colors.green,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTaskScreen(
                      task: task,
                      taskIndex: taskIndex,
                    ),
                  ),
                );
              },
              child: Text('Edit Task'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
