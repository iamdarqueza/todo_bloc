import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/home/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/screens/update_task/bloc/bloc.dart';
import 'package:todo_bloc/screens/update_task/bloc/update_task_state.dart';
import 'package:todo_bloc/utils/database_helper.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final TextEditingController dueDateController = TextEditingController();

  String? dateCreated;
  int? id;

  UpdateTaskBloc() : super(UpdateTaskState.empty());

  @override
  Stream<Transition<UpdateTaskEvent, UpdateTaskState>> transformEvents(
      Stream<UpdateTaskEvent> events, transitionFn) {
    var debounceStream = events
        .where((event) => event is TextFieldChanged)
        .debounceTime(Duration(milliseconds: 300));
    var nonDebounceStream = events.where((event) => event is! TextFieldChanged);
    return super.transformEvents(
        nonDebounceStream.mergeWith([debounceStream]), transitionFn);
  }

  @override
  Stream<UpdateTaskState> mapEventToState(UpdateTaskEvent event) async* {
    if (event is EmptyTask) {
      yield* _mapLoadEmptyState();
    } else if (event is UpdateExistingTask) {
      yield* _mapUpdateExistingToState(event.task);
    } else if (event is TextFieldChanged) {
      yield* _mapTextFieldChangedToState();
    }
  }

  Stream<UpdateTaskState> _mapTextFieldChangedToState() async* {
    yield state.update();
  }

    Stream<UpdateTaskState> _mapLoadEmptyState() async* {
    
  }

  Stream<UpdateTaskState> _mapUpdateExistingToState(Task task) async* {
    try {
      yield UpdateTaskState.loading();
      
      taskNameController.text = task.title;
      taskDescriptionController.text = task.description;

      dateCreated = task.dateCreated;

      var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSSSS');
      var inputDate = inputFormat.parse(task.dueDate);
      var outputFormat = DateFormat('EEEE, MMM d');
      var outputDate = outputFormat.format(inputDate);

      dueDateController.text = outputDate;

      await dbHelper.updateExistingTask(task);
      yield UpdateTaskState.success();
    } catch (e) {
      yield UpdateTaskState.failure("Add Task Failure");
    }
  }
}
