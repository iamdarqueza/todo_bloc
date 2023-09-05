import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/screens/new_task/bloc/bloc.dart';
import 'package:todo_bloc/screens/new_task/widgets/new_task_form.dart';

class NewTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewTaskBloc(),
        child: Scaffold(
          backgroundColor: Color(0xFFEEEEEE),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'New Task',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Syne',
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xFF2CAE76)),
              iconSize: 30,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.white,
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [NewTaskForm()],
          ),
        ));
  }
}
