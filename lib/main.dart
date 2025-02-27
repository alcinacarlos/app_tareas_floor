import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_tareas_floor/database.dart';
import 'package:app_tareas_floor/viewmodel/task_viewmodel.dart';
import 'package:app_tareas_floor/ui/screens/task_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskViewModel(taskDao: database.taskDao),
      child: TaskApp(),
    ),
  );
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaskListScreen(),
    );
  }
}
