import 'package:dio/dio.dart';

import 'package:todo_list/domain/models/task_model.dart';
import 'package:todo_list/data/repositories/task_repository.dart';
import 'package:todo_list/data/converters/task_converter.dart';
import 'package:todo_list/logging/logger.dart';

class NetworkRepository implements TaskRepository {
  // создаем синглтон
  NetworkRepository._internal();
  static final NetworkRepository _ = NetworkRepository._internal();
  factory NetworkRepository() => _;

  //
  final _dio = Dio();
  final _token = 'Pifast';
  final _baseURL = 'https://beta.mrdekk.ru/todobackend/list';

  // опции для получения и изменения данных
  Options get _gettingOptions => Options(headers: <String, dynamic>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      });
  Options get _settingOptions => Options(headers: <String, dynamic>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
        'X-Last-Known-Revision': _revision,
      });

  // работа с ревизией
  var _revision = 0;
  void _updateRevision(int value) => _revision = value;
  void _increaseRevision() => _revision++;

  // получаем все таски
  @override
  Future<List<TaskModel>?> getTasks([Importance? importance]) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        _baseURL,
        options: _gettingOptions,
      );
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
      logger.info(error);
      return null;
    }
  }

  // обновляем список тасок на сервере
  @override
  Future<List<TaskModel>?> updateTasks(List<TaskModel> data) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        _baseURL,
        data: data.map((item) => item.toJSON()).toList(),
        options: _settingOptions,
      );

      _increaseRevision();

      final tasks = (response.data!['list'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((data) => TaskConverter.fromJSON(data))
          .toList();

      return tasks;
    } catch (e) {
      logger.info(e);
      return null;
    }
  }

  // получаем таску по id
  @override
  Future<TaskModel?> getTask(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_baseURL/$id',
        options: _gettingOptions,
      );
      _updateRevision(response.data!['revision'] as int);
      return TaskConverter.fromJSON(response.data!);
    } catch (error) {
      logger.info(error);
      return null;
    }
  }

  // добавляем таску
  @override
  Future<bool> addTask(TaskModel data) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        _baseURL,
        data: data.toJSON(),
        options: _settingOptions,
      );
      _increaseRevision();
      final task = TaskConverter.fromJSON(response.data!);
      return task.id == data.id;
    } catch (error) {
      logger.info(error);
      return false;
    }
  }

  // удаление таски по id
  @override
  Future<bool> removeTask(String id) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        '$_baseURL/$id',
        options: _settingOptions,
      );
      _increaseRevision();
      final task = TaskConverter.fromJSON(response.data!["element"]);
      return task.id == id;
    } catch (error) {
      logger.info(error);
      return false;
    }
  }

  // изменение таски
  @override
  Future<bool> editTask(TaskModel data) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '$_baseURL/${data.id}',
        data: data.toJSON(),
        options: _settingOptions,
      );
      _increaseRevision();
      final task = TaskConverter.fromJSON(response.data!["element"]);
      return task.id == data.id;
    } catch (error) {
      logger.info(error);
      return false;
    }
  }
}
