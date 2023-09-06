import 'package:equatable/equatable.dart';
import 'package:todo_bloc/data/local/task.dart';

class UpdateTaskEvent extends Equatable {
  const UpdateTaskEvent();

  @override
  List<Object> get props => [];
}

class EmptyTask extends UpdateTaskEvent {}

class LoadCurrentTask extends UpdateTaskEvent {
  final Task task;
  LoadCurrentTask(this.task);
}

class UpdateExistingTask extends UpdateTaskEvent {
  final Task task;
  UpdateExistingTask(this.task);
}


/// When user changes email
class TextFieldChanged extends UpdateTaskEvent {}

/// When user changes password
class DescriptionChanged extends UpdateTaskEvent {
  final String description;

  DescriptionChanged({required this.description});

  @override
  String toString() {
    return '$description';
  }
}