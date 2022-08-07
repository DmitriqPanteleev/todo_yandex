import '../../domain/models/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>?> getTasks([Importance? importance]);
  Future<List<TaskModel>?> updateTasks(List<TaskModel> data);
  Future<TaskModel?> getTask(String id);
  Future<bool> addTask(TaskModel data);
  Future<bool> editTask(TaskModel data);
  Future<bool> removeTask(String id);
}
