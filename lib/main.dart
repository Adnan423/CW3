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

  /// Removing a task
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  ///Manager styling and orientation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row for input field and "Add" button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Task Name',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Expanded ListView to display tasks
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                child: Text('No tasks yet. Add a task!'),
              )
                  : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) =>
                            _toggleTaskCompletion(index, value),
                      ),
                      title: Text(
                        task.name,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteTask(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}