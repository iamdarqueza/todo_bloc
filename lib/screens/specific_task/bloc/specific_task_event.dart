import 'package:equatable/equatable.dart';
import 'package:todo_bloc/data/local/task.dart';

class SpecificTaskEvent extends Equatable {
  const SpecificTaskEvent();

  @override
  List<Object> get props => [];
}


class LoadTask extends SpecificTaskEvent {
  final int taskId;
  LoadTask(this.taskId);
}

class ToggleSpecificTask extends SpecificTaskEvent {
  final int taskId;
  ToggleSpecificTask(this.taskId);
}
