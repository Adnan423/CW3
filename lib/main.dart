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