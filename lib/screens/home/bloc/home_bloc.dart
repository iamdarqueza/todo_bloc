import 'package:flutter/material.dart';
import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/home/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/utils/database_helper.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  HomeBloc() : super(HomeLoading());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadHome) {
      yield* _mapLoadHomeToState();
    } else if (event is ToggleTaskHome) {
      yield* _mapToggleTaskHomeToState(event.taskId);
    } else if (event is RemoveTask) {
      yield* _mapRemoveTaskToState(event.taskId);
    }
  }

  Stream<HomeState> _mapLoadHomeToState() async* {
    try {
      
      yield HomeLoading();
      var incompleteTasks = await dbHelper.getCustomTasks(completed: false);
      var completedTasks = await dbHelper.getCustomTasks(completed: true);
      print('HOMESTATE!! ${incompleteTasks.length}');
      yield HomeLoaded(
          incompleteTaskResponse: incompleteTasks,
          completedTaskResponse: completedTasks);
    } catch (e) {
      yield HomeLoadFailure(e.toString());
    }
  }

  Stream<HomeState> _mapToggleTaskHomeToState(int taskId) async* {
    try {
      await dbHelper.toggleTaskCompletion(taskId);
      final incompleteTasks = await dbHelper.getCustomTasks(completed: false);
      final completedTasks = await dbHelper.getCustomTasks(completed: true);
      yield HomeLoaded(
          incompleteTaskResponse: incompleteTasks,
          completedTaskResponse: completedTasks);
    } catch (e) {
      yield HomeLoadFailure(e.toString());
    }
  }

  Stream<HomeState> _mapRemoveTaskToState(int taskId) async* {
    try {
      yield HomeLoading();
      await dbHelper.deleteTask(taskId);
      final incompleteTasks = await dbHelper.getCustomTasks(completed: false);
      final completedTasks = await dbHelper.getCustomTasks(completed: true);
      yield HomeLoaded(incompleteTaskResponse: incompleteTasks, completedTaskResponse: completedTasks);
    } catch (e) {
      yield HomeLoadFailure(e.toString());
    }
  }
}
