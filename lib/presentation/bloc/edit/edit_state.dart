part of 'edit_cubit.dart';

// экран загружается, экран загрузился, экран отправляет отредаченное, экран добавляет новое

abstract class EditState extends Equatable {
  const EditState();
}

class EditInitial extends EditState {
  final TaskModel task;

  const EditInitial(this.task);

  @override
  List<Object?> get props => [task];
}

class EditLoading extends EditState {
  const EditLoading();

  @override
  List<Object?> get props => [];
}

class EditSuccess extends EditState {
  const EditSuccess();

  @override
  List<Object?> get props => [];
}

class EditError extends EditState {
  final String message;

  const EditError(this.message);

  @override
  List<Object?> get props => [message];
}
