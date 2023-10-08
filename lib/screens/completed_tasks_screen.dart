import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'task_detail_screen.dart';

class CompletedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks'),
        backgroundColor: Colors.green,
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskData, child) {
          return taskData.completedTasks.isEmpty
              ? Center(
                  child: Text('No Completed Tasks Yet!',
                      style: TextStyle(fontSize: 18, color: Colors.green)),
                )
              : ListView.builder(
                  itemCount: taskData.completedTasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 5,
                      child: ListTile(
                        title: Text(taskData.completedTasks[index].title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle:
                            Text(taskData.completedTasks[index].description),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailScreen(
                                task: taskData.completedTasks[index],
                                taskIndex: index,
                              ),
                            ),
                          );
                        },
                        trailing: IconButton(
                          icon: Icon(Icons.undo),
                          onPressed: () {
                            taskData.uncompleteTask(index);
                          },
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
