import 'package:dio/dio.dart';

import 'package:todo_list/data/converter.dart';
import 'package:todo_list/data/repository.dart';
import 'package:todo_list/domain/models/task.dart';

class API implements TaskRepository {
  API._internal();
  static final API _ = API._internal();
  factory API() => _;

  final _dio = Dio();
  final _token = "Pifast";
  final _baseURL = "https://beta.mrdekk.ru/todobackend/list";

  var _revision = 0;
  void _increaseRevision() => _revision++;

  Future<void> authorize() async {
    try {
      final response = await _dio.get(
        _baseURL,
        options: Options(headers: {
          "Authorization": "Bearer $_token",
        }),
      );
      _revision = response.data["revision"];
      print(response.data);
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<List<Task>?> getTasks([Importance? importance]) async {
    try {
      final response = await _dio.get(
        _baseURL,
        options: Options(headers: {
          "Authorization": "Bearer $_token",
        }),
      );
      // print(response.data);
      final tasks = (response.data["list"] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((data) => TaskConverter.fromJSON(data))
          .toList();
      if (importance == null) {
        return tasks;
      }
      return tasks
          .where((element) => element.importance == importance)
          .toList();
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Future<Task?> getTask(String id) async {
    try {
      final response = await _dio.get(
        "$_baseURL/$id",
        options: Options(headers: {
          "Authorization": "Bearer $_token",
        }),
      );
      print(response);
      return TaskConverter.fromJSON(response.data);
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Future<bool> addTask(Task data) async {
    try {
      final response = await _dio.post(
        _baseURL,
        data: data.toJSON(),
        options: Options(headers: {
          "Authorization": "Bearer $_token",
          "X-Last-Known-Revision": _revision,
          "Content-Type": "application/json"
        }),
      );
      print(response);
      _increaseRevision();
      final task = TaskConverter.fromJSON(response.data);
      return task.id == data.id;
    } catch (error) {
      print(error);
      return false;
    }
  }

  @override
  Future<bool> removeTask(String id) async {
    try {
      final response = await _dio.delete(
        "$_baseURL/$id",
        options: Options(headers: {
          "Authorization": "Bearer $_token",
          "X-Last-Known-Revision": _revision,
        }),
      );
      print(response);
      _increaseRevision();
      final task = TaskConverter.fromJSON(response.data);
      return task.id == id;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
