import 'package:equatable/equatable.dart';
import 'package:todo_bloc/data/local/task.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadEmptyHome extends HomeEvent {}

class LoadHome extends HomeEvent {}

class ToggleTaskHome extends HomeEvent {
  final int taskId;
  ToggleTaskHome(this.taskId);
}

class RemoveTask extends HomeEvent {
  final int taskId;
  RemoveTask(this.taskId);
}
