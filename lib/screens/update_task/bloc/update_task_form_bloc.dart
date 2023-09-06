import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/home/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/screens/update_task/bloc/bloc.dart';
import 'package:todo_bloc/utils/database_helper.dart';

class UpdateTaskFormBloc extends Bloc<UpdateTaskEvent, UpdateTaskFormState> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final TextEditingController dueDateController = TextEditingController();

  String? dateCreated;
  int? id;
  String? dueDate;

  UpdateTaskFormBloc() : super(UpdateTaskFormLoading());

  @override
  Stream<UpdateTaskFormState> mapEventToState(UpdateTaskEvent event) async* {
    if (event is LoadCurrentTask) {
      yield* _mapLoadCurrentTaskToState(event.task);
    } else if (event is UpdateExistingTask) {
      yield* _mapUpdateTaskToState(event.task);
    }
  }

  Stream<UpdateTaskFormState> _mapLoadCurrentTaskToState(Task task) async* {
    try {
      yield UpdateTaskFormLoading();
      print('LOAD ${task.id} ${task.title} ${task.dueDate}');
      id = task.id;
      taskNameController.text = task.title;
      taskDescriptionController.text = task.description;

      dateCreated = task.dateCreated;

      var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSSSS');
      var inputDate = inputFormat.parse(task.dueDate);
      var outputFormat = DateFormat('EEEE, MMM d');
      var outputDate = outputFormat.format(inputDate);
      var inputToString = inputFormat.format(inputDate);

      dueDateController.text = outputDate;
      dueDate = inputToString;

      yield UpdateTaskFormLoaded(task: task);
    } catch (e) {
      yield UpdateTaskFormLoadFailure(e.toString());
    }
  }

  Stream<UpdateTaskFormState> _mapUpdateTaskToState(Task task) async* {
    try {
      yield UpdateTaskFormLoading();
      print('UPDATE ${task.id} ${task.title} ${task.dueDate}');
      taskNameController.text = task.title;
      taskDescriptionController.text = task.description;

      dateCreated = task.dateCreated;

      var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSSSS');
      var inputDate = inputFormat.parse(task.dueDate);
      var outputFormat = DateFormat('EEEE, MMM d');
      var outputDate = outputFormat.format(inputDate);
      var inputToString = inputFormat.format(inputDate);

      dueDateController.text = outputDate;
      dueDate = inputToString;

      yield UpdateTaskFormNewLoaded(task: task);
    } catch (e) {
      yield UpdateTaskFormLoadFailure(e.toString());
    }
  }
}
