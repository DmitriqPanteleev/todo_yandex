import 'package:dio/dio.dart';

import 'package:todo_list/domain/models/task_model.dart';
import 'package:todo_list/data/repositories/task_repository.dart';
import 'package:todo_list/data/converters/task_converter.dart';

class API implements TaskRepository {
  API._internal();
  static final API _ = API._internal();
  factory API() => _;

  final _dio = Dio();
  final _token = 'Pifast';
  final _baseURL = 'https://beta.mrdekk.ru/todobackend/list';

  Options get _gettingOptions => Options(headers: <String, dynamic>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      });
  Options get _settingOptions => Options(headers: <String, dynamic>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
        'X-Last-Known-Revision': _revision,
      });

  var _revision = 0;
  void _updateRevision(int value) => _revision = value;
  void _increaseRevision() => _revision++;

  @override
  Future<List<TaskModel>?> getTasks([Importance? importance]) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        _baseURL,
        options: _gettingOptions,
      );
      print(response.data);
      _updateRevision(response.data!['revision'] as int);
      final tasks = (response.data!['list'] as List<dynamic>)
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
  Future<TaskModel?> getTask(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_baseURL/$id',
        options: _gettingOptions,
      );
      print(response.data);
      _updateRevision(response.data!['revision'] as int);
      return TaskConverter.fromJSON(response.data!);
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Future<bool> addTask(TaskModel data) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _baseURL,
        data: data.toJSON(),
        options: _settingOptions,
      );
      print(response.data);
      _increaseRevision();
      final task = TaskConverter.fromJSON(response.data!);
      return task.id == data.id;
    } catch (error) {
      print(error);
      return false;
    }
  }

  @override
  Future<bool> removeTask(String id) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        '$_baseURL/$id',
        options: _settingOptions,
      );
      print(response.data);
      _increaseRevision();
      final task = TaskConverter.fromJSON(response.data!);
      return task.id == id;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
