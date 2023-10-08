import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'task_detail_screen.dart';

class PendingTasksScreen extends StatelessWidget {
  void _showAddTaskSheet(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter task title',
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.title, color: Colors.deepPurple),
                    ),
                  ),
                  SizedBox(height: 10), // Added for spacing
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter task description',
                      labelStyle: TextStyle(color: Colors.deepPurple),
                      hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon:
                          Icon(Icons.description, color: Colors.deepPurple),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 10), // Added for spacing
                  ElevatedButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      // ignore: use_build_context_synchronously
                      final selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (selectedDate != null &&
                          selectedTime != null &&
                          titleController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
                        final task = Task(
                          title: titleController.text,
                          description: descriptionController.text,
                          dueDate: DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          ),
                          dueTime: selectedTime,
                        );
                        // ignore: use_build_context_synchronously
                        Provider.of<TaskProvider>(Navigator.of(context).context,
                                listen: false)
                            .addTask(task);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      } else {
                        // Optionally show an error message to the user
                      }
                    },
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Tasks'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskData, child) {
          return taskData.tasks.isEmpty
              ? const Center(
                  child: Text('No Tasks Yet!',
                      style: TextStyle(fontSize: 18, color: Colors.deepPurple)),
                )
              : ListView.builder(
                  itemCount: taskData.tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      elevation: 5,
                      child: ListTile(
                        title: Text(taskData.tasks[index].title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: Text(taskData.tasks[index].description),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailScreen(
                                task: taskData.tasks[index],
                                taskIndex: index,
                              ),
                            ),
                          );
                        },
                        trailing: IconButton(
                          icon: Icon(Icons.done),
                          onPressed: () {
                            taskData.completeTask(index);
                          },
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskSheet(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
