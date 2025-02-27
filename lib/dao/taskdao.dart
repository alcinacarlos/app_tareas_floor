import 'package:app_tareas_floor/model/task.dart';
import 'package:floor/floor.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM Task')
  Future<List<Task>> findAllTasks();

  @Query('SELECT * FROM Task WHERE id = :id')
  Stream<Task?> findTaskById(int id);

  @insert
  Future<void> insertTask(Task task);

  @update
  Future<void> updateTask(Task task);

  @delete
  Future<void> deleteTask(Task task);
}