import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/home/bloc/bloc.dart';
import 'package:todo_bloc/screens/specific_task/specific_task_screen.dart';
import 'package:todo_bloc/utils/font_constant.dart';

class TaskWidget extends StatelessWidget {
  final Task task;

  TaskWidget({required this.task});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        title: Text(
          task.title,
          style: task.isCompleted ? FONT_CONST.TODO_TITLE_STRIKE : FONT_CONST.TODO_TITLE,
        ),
        subtitle: _buildDueDateFormat(task.dueDate),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            BlocProvider.of<HomeBloc>(context)
                .add(ToggleTaskHome(task.id ?? 0));
          },
        ),
      ),
      onTap: () {
        Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SpecificTaskScreen(task: task,))).then((value) => {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          BlocProvider.of<HomeBloc>(context).add(LoadHome());
                        })
                      });
      },
    );
  }

  _buildDueDateFormat(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    var inputDate = inputFormat.parse(date);

    var outputFormat = DateFormat('EEEE, MMM d');
    var outputDate = outputFormat.format(inputDate);

    return Text('Due on $outputDate', style: FONT_CONST.TODO_DESC);
  }
}
