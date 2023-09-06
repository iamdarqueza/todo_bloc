import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_bloc/data/local/task.dart';

@immutable
class UpdateTaskState {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? message;


  UpdateTaskState({
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.message,
  });

  factory UpdateTaskState.empty() {
    return UpdateTaskState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      message: "",
    );
  }

  factory UpdateTaskState.loading() {
    return UpdateTaskState(
        isSubmitting: true,
        isSuccess: false,
        isFailure: false,
        message: "Loading ...");
  }

  factory UpdateTaskState.failure(String message) {
    return UpdateTaskState(
      isSuccess: false,
      isSubmitting: false,
      isFailure: true,
      message: message,
    );
  }

  factory UpdateTaskState.success() {
    return UpdateTaskState(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      message: "Sucess",
    );
  }

    UpdateTaskState update() {
    return cloneWith(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      message: "",
    );
  }

  UpdateTaskState cloneWith({
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? message,
  }) {
    return UpdateTaskState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'UpdateTaskState{isSubmitting: $isSubmitting, isSuccess: $isSuccess, isFailure: $isFailure, message: $message}';
  }
  
}


