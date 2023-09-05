import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/home/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// Loading
class HomeLoading extends HomeState {}

// Home data
class HomeLoaded extends HomeState {
  final List<Task> incompleteTaskResponse;
  final List<Task> completedTaskResponse;

  const HomeLoaded({required this.incompleteTaskResponse, required this.completedTaskResponse});

  @override
  List<Object?> get props => [incompleteTaskResponse, completedTaskResponse];
}

/// Failure
class HomeLoadFailure extends HomeState {
  final String error;

  const HomeLoadFailure(this.error);
}
