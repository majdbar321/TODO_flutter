import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class EditTaskScreen extends StatelessWidget {
  final Task task;
  final int taskIndex;

  EditTaskScreen({required this.task, required this.taskIndex});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: () {
                if (task.isComplete) {
                  Provider.of<TaskProvider>(context, listen: false).updateTask(
                    taskIndex,
                    Task(
                      title: titleController.text,
                      description: descriptionController.text,
                      dueDate: task.dueDate,
                      dueTime: task.dueTime,
                      isComplete: task.isComplete,
                    ),
                  );
                } else {
                  Provider.of<TaskProvider>(context, listen: false)
                      .updateTaskcomplete(
                    taskIndex,
                    Task(
                      title: titleController.text,
                      description: descriptionController.text,
                      dueDate: task.dueDate,
                      dueTime: task.dueTime,
                      isComplete: task.isComplete,
                    ),
                  );
                }
                // Update the task logic...

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
