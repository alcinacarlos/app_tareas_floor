import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_tareas_floor/model/task.dart';
import 'package:app_tareas_floor/viewmodel/task_viewmodel.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final bool isSelected;
  final bool isSelecting;
  final VoidCallback onLongPress;
  final VoidCallback onTap;

  const TaskListItem({
    super.key,
    required this.task,
    required this.isSelected,
    required this.isSelecting,
    required this.onLongPress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);

    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        color: isSelected ? Colors.deepPurple.withAlpha(100) : Colors.white,
        child: ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            task.description,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          leading:
              isSelecting
                  ? Icon(
                    isSelected
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: isSelected ? Colors.deepPurple : Colors.grey,
                  )
                  : null,
          trailing: IconButton(
            icon: Icon(
              task.isCompleted
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: task.isCompleted ? Colors.deepPurple : Colors.grey,
            ),
            onPressed: () {
              final updatedTask = Task(
                task.id,
                task.title,
                task.description,
                !task.isCompleted,
              );
              taskViewModel.updateTask(updatedTask);
            },
          ),
        ),
      ),
    );
  }
}
