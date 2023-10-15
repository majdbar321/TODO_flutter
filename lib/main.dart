import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'screens/pending_tasks_screen.dart';
import 'screens/completed_tasks_screen.dart';

//Marcell - Lack of comments explaining the code

//Marcell - Could be put into a different file so the main function doesn't clutter the apps code
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MyApp(),
    ),
  );
}

//Marcell - the app doesn't take into consideration how big the screen is and therefore only uses BottomNavBar
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  //Marcell - good idea using a list so it can be easily scaled with different pages without changin much of the code
  final List<Widget> _screens = [PendingTasksScreen(), CompletedTasksScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        //Marcell - 'const' could be used because the icons will never be changed while the program is runing
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.pending_actions), label: 'Pending'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
