import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/data/api.dart';

import '../../../domain/models/task.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  Future<void> getTasks([Importance? importance]) async {
    emit(const HomeLoading());

    try {
      final result = await API().getTasks(importance);

      if (result == null) {
        emit(const HomeError(message: "Have no list of tasks"));
      }

      emit(HomeLoaded(tasks: result!));
    } catch (e) {
      emit(const HomeError(message: "An error has catched"));
    }
  }

  Future<void> removeTask(String id) async {}
}
