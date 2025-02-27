# Aplicación de Tareas con Flutter, Floor y Provider

Esta es una aplicación simple de gestión de tareas hecha con Flutter. Utiliza la biblioteca Floor para la gestión de bases de datos locales y el paquete Provider para la gestión de estados

## Uso de Floor para la Gestión de Bases de Datos

Floor es una biblioteca de persistencia para Flutter y Dart, inspirada en Room para Android. Proporciona una capa de abstracción sobre SQLite para permitir un acceso más robusto a la base de datos aprovechando todo el poder de SQLite.

### Definiendo la Entidad

La entidad `Task` se define en `model/task.dart`:

```dart
@entity
class Task {
    @primaryKey
    final int id;
    final String title;
    final String description;
    final bool isCompleted;

    Task(this.id, this.title, this.description, this.isCompleted);
}
```

### Creando el DAO

El `TaskDao` se define en `dao/taskdao.dart`:

```dart
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
```

### Base de Datos

La `AppDatabase` se define en `database.dart`:

```dart
@Database(version: 1, entities: [Task])
abstract class AppDatabase extends FloorDatabase {
    TaskDao get taskDao;
}
```


## Pantallas

### TaskListScreen

Muestra la lista de tareas y permite la selección y eliminación de tareas

### AddTaskScreen

Permite al usuario agregar una nueva tarea

### EditTaskScreen

Permite al usuario editar una tarea existente

## ViewModel

El `TaskViewModel` es responsable de gestionar el estado de las tareas. Interactúa con el `TaskDao` para realizar operaciones CRUD en las tareas y notifica a los oyentes cuando el estado cambia.