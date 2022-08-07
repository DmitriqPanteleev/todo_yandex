import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/logging/logger.dart';

import '../../../data/repositories/network_repository.dart';
import '../../../domain/models/task_model.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit({
    required TaskModel task,
  }) : super(EditInitial(task));

  Future<void> addTask(TaskModel task) async {
    try {
      emit(const EditLoading());
      final response = await NetworkRepository().addTask(task);
      // в ином случае сообщаем пользователю о том, что таска не добавилась
      if (!response) {
        emit(const EditError('Task has not been added'));
      }
      // при удачном добавлении таски возвращаемся на домашний экран
      emit(const EditSuccess());
    } catch (e) {
      emit(const EditError('Task has not been added'));
    }
  }

  Future<void> editTask(TaskModel data) async {
    try {
      emit(const EditLoading());
      final response = await NetworkRepository().editTask(data);
      if (!response) {
        emit(const EditError('the task was not edited'));
      }
      emit(const EditSuccess());
      logger.info("Task with ID:${data.id} has been edited");
    } catch (e) {
      logger.info(e);
    }
  }

  Future<void> removeTask(String id) async {
    try {
      emit(const EditLoading());
      final response = await NetworkRepository().removeTask(id);
      if (!response) {
        emit(const EditError('Task has not been removed'));
      }
      // при удачном удалении таски возвращаемся на домашний экран
      emit(const EditSuccess());
    } catch (e) {
      emit(const EditError('Task has not been removed'));
    }
  }
}
