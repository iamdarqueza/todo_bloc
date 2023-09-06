import 'package:rxdart/rxdart.dart';
import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/home/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/screens/specific_task/bloc/bloc.dart';
import 'package:todo_bloc/utils/database_helper.dart';

class SpecificTaskBloc extends Bloc<SpecificTaskEvent, SpecificTaskState> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  SpecificTaskBloc() : super(SpecificTaskLoading());

  @override
  Stream<SpecificTaskState> mapEventToState(SpecificTaskEvent event) async* {
    if (event is LoadTask) {
      yield* _mapLoadSpecificTaskToState(event.taskId);
    } else if (event is ToggleSpecificTask) {
       yield* _mapToggleSpecificTaskToState(event.taskId);
    }
  }

  Stream<SpecificTaskState> _mapLoadSpecificTaskToState(int id) async* {
    try {
      yield SpecificTaskLoading();
      final task = await dbHelper.getTaskById(id);
      yield SpecificTaskLoaded(task: task!);
    } catch (e) {
      yield SpecificTaskLoadFailure(e.toString());
    }
  }

  Stream<SpecificTaskState> _mapToggleSpecificTaskToState(int id) async* {
    try {
      yield SpecificTaskLoading();
      await dbHelper.toggleTaskCompletion(id);
      final task = await dbHelper.getTaskById(id);
      yield SpecificTaskLoaded(task: task!);
    } catch (e) {
      yield SpecificTaskLoadFailure(e.toString());
    }
  }
}
