import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/home/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class SpecificTaskState extends Equatable {
  const SpecificTaskState();

  @override
  List<Object?> get props => [];
}

/// Loading
class SpecificTaskLoading extends SpecificTaskState {}

// Home data
class SpecificTaskLoaded extends SpecificTaskState {
  final Task task;

  const SpecificTaskLoaded({required this.task});

  @override
  List<Object?> get props => [task];
}

/// Failure
class SpecificTaskLoadFailure extends SpecificTaskState {
  final String error;

  const SpecificTaskLoadFailure(this.error);
}
