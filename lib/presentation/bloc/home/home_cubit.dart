import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/logging/logger.dart';

import '../../../data/repositories/network_repository.dart';
import '../../../domain/models/task_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial()) {
    getTasks();
  }

  Future<void> getTasks([Importance? importance]) async {
    try {
      emit(const HomeLoading());
      final result = await NetworkRepository().getTasks(importance);

      if (result == null) {
        emit(const HomeError("Have no list of tasks"));
      }
      logger.info('Tasks are loaded');

      emit(HomeLoaded(result!));
    } catch (e) {
      emit(const HomeError("An error has catched"));
    }
  }

  Future<void> editTask(TaskModel data) async {
    try {
      emit(const HomeLoading());
      final response = await NetworkRepository().editTask(data);

      if (!response) {
        emit(const HomeError('the task was not edited'));
      }
      logger.info("Task with ID:${data.id} has been edited");

      getTasks();
    } catch (e) {
      logger.info(e);
    }
  }

  Future<void> removeTask(String id) async {
    try {
      emit(const HomeLoading());
      final response = await NetworkRepository().removeTask(id);

      if (!response) {
        emit(const HomeError('the task was not removed'));
      }
      logger.info("Task with ID:$id has been removed");

      getTasks();
    } catch (e) {
      logger.info(e);
    }
  }
}
