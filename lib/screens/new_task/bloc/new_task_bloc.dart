import 'package:rxdart/rxdart.dart';
import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/home/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/screens/new_task/bloc/bloc.dart';
import 'package:todo_bloc/utils/database_helper.dart';

class NewTaskBloc extends Bloc<NewTaskEvent, NewTaskState> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  NewTaskBloc() : super(NewTaskState.empty());

    @override
  Stream<Transition<NewTaskEvent, NewTaskState>> transformEvents(
      Stream<NewTaskEvent> events, transitionFn) {
    var debounceStream = events
        .where((event) =>
            event is TextFieldChanged)
        .debounceTime(Duration(milliseconds: 300));
    var nonDebounceStream = events.where((event) =>
        event is! TextFieldChanged);
    return super.transformEvents(
        nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }

  @override
  Stream<NewTaskState> mapEventToState(NewTaskEvent event) async* {
    if (event is AddTask) {
      yield* _mapAddNewTaskToState(event.task);
    } else if (event is TextFieldChanged) {
      yield* _mapTextFieldChangedToState();
    } 
  }

  
  Stream<NewTaskState> _mapTextFieldChangedToState() async* {
    yield state.update();
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
