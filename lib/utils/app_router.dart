import 'package:todo_bloc/screens/home/home_screen.dart';
import 'package:todo_bloc/screens/new_task/new_task_screen.dart';
import 'package:flutter/material.dart';


class AppRouter {
  static const String HOME = '/home';
  static const String ADDTASK = '/add_task';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(),
            settings: RouteSettings(name: 'Home'));
      case ADDTASK:
        return MaterialPageRoute(
          builder: (_) => NewTaskScreen(),
        );
     
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  ///Singleton factory
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();
}
