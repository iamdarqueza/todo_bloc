import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/app_view.dart';
import 'package:todo_bloc/screens/home/bloc/bloc.dart';
import 'package:todo_bloc/screens/home/home_screen.dart';
import 'package:todo_bloc/screens/new_task/bloc/new_task_bloc.dart';
import 'package:todo_bloc/screens/specific_task/bloc/specific_task_bloc.dart';
import 'package:todo_bloc/screens/update_task/bloc/bloc.dart';
import 'package:todo_bloc/screens/update_task/bloc/update_task_bloc.dart';
import 'package:todo_bloc/utils/size_config.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeBloc()),
          BlocProvider(create: (context) => NewTaskBloc()),
          BlocProvider(create: (context) => SpecificTaskBloc()),
          BlocProvider(create: (context) => UpdateTaskBloc()),
        ],
        child: LayoutBuilder(
          builder: (context, constraints) {
            return OrientationBuilder(
              builder: (context, orientation) {
                SizeConfig().init(constraints, orientation);
                return AppView();
              },
            );
          },
        ));
  }
}
