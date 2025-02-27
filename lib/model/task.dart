import 'package:floor/floor.dart';

@entity
class Task {
  @primaryKey
  final int id;

  final String title;
  final String description;
  final bool isCompleted;

  Task(this.id, this.title, this.description, this.isCompleted);
}