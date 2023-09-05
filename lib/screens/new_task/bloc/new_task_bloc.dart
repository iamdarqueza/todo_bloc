import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/home/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/screens/new_task/bloc/bloc.dart';
import 'package:todo_bloc/utils/database_helper.dart';

class NewTaskBloc extends Bloc<NewTaskEvent, NewTaskState> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  NewTaskBloc() : super(NewTaskState.empty());

  @override
  Stream<NewTaskState> mapEventToState(NewTaskEvent event) async* {
    if (event is AddTask) {
      yield* _mapAddNewTaskToState(event.task);
    }
  }

  Stream<NewTaskState> _mapAddNewTaskToState(Task task) async* {
    try {
      yield NewTaskState.loading();
      await dbHelper.insertTask(task);
      yield NewTaskState.success();
    } catch (e) {
      yield NewTaskState.failure("Add Task Failure");
    }
  }
}
