import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_bloc/data/local/task.dart';

abstract class UpdateTaskFormState extends Equatable {
  const UpdateTaskFormState();

  @override
  List<Object?> get props => [];
}

/// Loading
class UpdateTaskFormLoading extends UpdateTaskFormState {}

// Home data
class UpdateTaskFormLoaded extends UpdateTaskFormState {
  final Task task;
  const UpdateTaskFormLoaded({required this.task});

  @override
  List<Object?> get props => [task];
}

class UpdateTaskFormNewLoaded extends UpdateTaskFormState {
  final Task task;
  const UpdateTaskFormNewLoaded({required this.task});

  @override
  List<Object?> get props => [task];
}

/// Failure
class UpdateTaskFormLoadFailure extends UpdateTaskFormState {
  final String error;

  const UpdateTaskFormLoadFailure(this.error);
}
