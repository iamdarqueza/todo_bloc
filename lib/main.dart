import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/app_view.dart';
import 'package:todo_bloc/screens/home/bloc/bloc.dart';
import 'package:todo_bloc/screens/home/home_screen.dart';
import 'package:todo_bloc/utils/size_config.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return AppView();
            
          },
        );
      },
    );
  }
}
