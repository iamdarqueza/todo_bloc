import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/screens/new_task/bloc/bloc.dart';
import 'package:todo_bloc/screens/new_task/widgets/new_task_form.dart';
import 'package:todo_bloc/utils/font_constant.dart';

class NewTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewTaskBloc(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'New Task',
              style: FONT_CONST.BOLD_DEFAULT_20,
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
