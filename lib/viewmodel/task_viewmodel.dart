import 'package:flutter/material.dart';
import 'package:app_tareas_floor/model/task.dart';
import 'package:app_tareas_floor/dao/taskdao.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskDao taskDao;
  List<Task> _tasks = [];
  final Set<int> _selectedTasks = {};
  bool _isSelecting = false;

  List<Task> get tasks => _tasks;
  Set<int> get selectedTasks => _selectedTasks;
  bool get isSelecting => _isSelecting;

  TaskViewModel({required this.taskDao}) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    _tasks = await taskDao.findAllTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await taskDao.insertTask(task);
    _loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await taskDao.updateTask(task);
    _loadTasks();
  }

  Future<void> deleteTask(Task task) async {
    await taskDao.deleteTask(task);
    _loadTasks();
  }

  void toggleSelection(int taskId) {
    if (_selectedTasks.contains(taskId)) {
      _selectedTasks.remove(taskId);
    } else {
      _selectedTasks.add(taskId);
    }
    _isSelecting = _selectedTasks.isNotEmpty;
    notifyListeners();
  }

  Future<void> deleteSelectedTasks() async {
    for (int taskId in _selectedTasks) {
      await taskDao.deleteTask(Task(taskId, "", "", false));
    }
    _selectedTasks.clear();
    _isSelecting = false;
    _loadTasks();
  }

  void clearSelection() {
    _selectedTasks.clear();
    _isSelecting = false;
    notifyListeners();
  }
}
