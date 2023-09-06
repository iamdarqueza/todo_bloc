import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/screens/home/bloc/home_bloc.dart';
import 'package:todo_bloc/screens/home/bloc/home_event.dart';
import 'package:todo_bloc/screens/home/widgets/home_header.dart';
import 'package:todo_bloc/screens/home/widgets/home_list.dart';
import 'package:todo_bloc/screens/new_task/new_task_screen.dart';
import 'package:todo_bloc/utils/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadEmptyHome()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        HomeHeader(),
                        SizedBox(
                          height: 20,
                        ),
                        HomeList(),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ))),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NewTaskScreen())).then((value) => {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          BlocProvider.of<HomeBloc>(context).add(LoadHome());
                        })
                      });
                },
                backgroundColor: Color(0xFF2CAE76),
                child: Icon(Icons.add, color: Colors.white)),
          );
        },
      ),
    );
  }
}
