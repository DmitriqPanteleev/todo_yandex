import 'package:todo_list/domain/models/task.dart';

abstract class TaskRepository {
  Future<List<Task>?> getTasks([Importance? importance]);
  Future<Task?> getTask(String id);
  Future<bool> addTask(Task data);
  Future<bool> removeTask(String id);
}
