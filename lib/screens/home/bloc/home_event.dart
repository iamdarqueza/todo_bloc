import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHome extends HomeEvent {}

class ToggleTaskHome extends HomeEvent {
  final int taskId;
  ToggleTaskHome(this.taskId);
}
