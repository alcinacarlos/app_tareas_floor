import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:app_tareas_floor/model/task.dart';
import 'package:app_tareas_floor/dao/taskdao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Task])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}