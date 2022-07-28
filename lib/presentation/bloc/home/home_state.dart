part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();

  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  final List<Task> tasks;

  const HomeLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}
