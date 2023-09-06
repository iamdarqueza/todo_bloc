import 'package:equatable/equatable.dart';
import 'package:todo_bloc/data/local/task.dart';

class NewTaskEvent extends Equatable {
  const NewTaskEvent();

  @override
  List<Object> get props => [];
}

class EmptyTask extends NewTaskEvent {}

class LoadTask extends NewTaskEvent {}

class AddTask extends NewTaskEvent {
  final Task task;
  AddTask(this.task);
}


/// When user changes email
class TextFieldChanged extends NewTaskEvent {}

/// When user changes password
class DescriptionChanged extends NewTaskEvent {
  final String description;

  DescriptionChanged({required this.description});

  @override
  String toString() {
    return '$description';
  }
}