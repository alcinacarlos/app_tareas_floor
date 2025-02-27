import 'package:app_tareas_floor/ui/items/task_list_item.dart';
import 'package:app_tareas_floor/ui/screens/add_task_screen.dart';
import 'package:app_tareas_floor/ui/screens/edit_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_tareas_floor/viewmodel/task_viewmodel.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(taskViewModel.isSelecting
            ? "${taskViewModel.selectedTasks.length} selected"
            : "Task List"),
        actions: taskViewModel.isSelecting
            ? [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: taskViewModel.deleteSelectedTasks,
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: taskViewModel.clearSelection,
                ),
              ]
            : [],
      ),
      body: taskViewModel.tasks.isEmpty
          ? Center(child: Text('No tasks found'))
          : ListView.builder(
              itemCount: taskViewModel.tasks.length,
              itemBuilder: (context, index) {
                final task = taskViewModel.tasks[index];
                return TaskListItem(
                  task: task,
                  isSelected: taskViewModel.selectedTasks.contains(task.id),
                  isSelecting: taskViewModel.isSelecting,
                  onLongPress: () => taskViewModel.toggleSelection(task.id),
                  onTap: () {
                    if (taskViewModel.isSelecting) {
                      taskViewModel.toggleSelection(task.id);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTaskScreen(
                            task: task,
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
