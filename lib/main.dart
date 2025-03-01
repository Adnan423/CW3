import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Task with name and completion.
class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // List to hold tasks
  final List<Task> _tasks = [];

  // Controller for the task name input field
  final TextEditingController _taskController = TextEditingController();

  /// Adding a new task
  void _addTask() {
    final taskName = _taskController.text.trim();
    if (taskName.isNotEmpty) {
      setState(() {
        _tasks.add(Task(name: taskName));
      });
      _taskController.clear();
    }
  }

  /// Task completion
  void _toggleTaskCompletion(int index, bool? value) {
    setState(() {
      _tasks[index].isCompleted = value ?? false;
    });
  }