import 'package:flutter/material.dart';

@immutable
class NewTaskState {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? message;


  NewTaskState({
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.message,
  });

  factory NewTaskState.empty() {
    return NewTaskState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      message: "",
    );
  }

  factory NewTaskState.loading() {
    return NewTaskState(
        isSubmitting: true,
        isSuccess: false,
        isFailure: false,
        message: "Loading ...");
  }

  factory NewTaskState.failure(String message) {
    return NewTaskState(
      isSuccess: false,
      isSubmitting: false,
      isFailure: true,
      message: message,
    );
  }

  factory NewTaskState.success() {
    return NewTaskState(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      message: "Login Sucess",
    );
  }

  NewTaskState cloneWith({
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? message,
  }) {
    return NewTaskState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'NewTaskState{isSubmitting: $isSubmitting, isSuccess: $isSuccess, isFailure: $isFailure, message: $message}';
  }
}
