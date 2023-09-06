import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/update_task/bloc/bloc.dart';
import 'package:todo_bloc/screens/update_task/widgets/update_task_form.dart';
import 'package:todo_bloc/utils/font_constant.dart';

class UpdateTaskScreen extends StatelessWidget {
  final Task task;

  const UpdateTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UpdateTaskFormBloc()..add(LoadCurrentTask(task)),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Update Task',
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
          body: UpdateTaskForm(task: task,),
        ));
  }
}
