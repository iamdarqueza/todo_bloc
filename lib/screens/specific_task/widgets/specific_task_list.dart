import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/home/bloc/home_bloc.dart';
import 'package:todo_bloc/screens/home/bloc/home_event.dart';
import 'package:todo_bloc/screens/specific_task/bloc/bloc.dart';
import 'package:todo_bloc/utils/color_constant.dart';
import 'package:todo_bloc/utils/default_button.dart';
import 'package:todo_bloc/utils/dialog.dart';
import 'package:todo_bloc/utils/font_constant.dart';
import 'package:todo_bloc/utils/loading.dart';
import 'package:todo_bloc/utils/size_config.dart';
import 'package:intl/intl.dart';

class SpecificTaskList extends StatefulWidget {
  final Task task;

  const SpecificTaskList({Key? key, required this.task}) : super(key: key);

  @override
  _SpecificTaskListState createState() => _SpecificTaskListState();
}

class _SpecificTaskListState extends State<SpecificTaskList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecificTaskBloc, SpecificTaskState>(
      builder: (context, specificTaskState) {
        if (specificTaskState is SpecificTaskLoaded) {
          var task = specificTaskState.task;

          return Container(
            margin: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultPadding,
              vertical: SizeConfig.defaultSize * 3,
            ),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildCheckbox(task.isCompleted, task.id ?? 0),
                  SizedBox(height: SizeConfig.defaultSize),
                  _buildIsComplete(task.isCompleted),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  _buildTitle(task.title),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  _buildDescription(task.description),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  _buildDueDate(task.dueDate),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  // _buildButtonAddTask(),
                ],
              ),
            ),
          );
        }

        if (specificTaskState is SpecificTaskLoading) {
          return Loading();
        }
        if (specificTaskState is SpecificTaskLoadFailure) {
          return Center(child: Text(specificTaskState.error));
        }
        return Center(child: Text(''));
      },
    );
  }

  _buildCheckbox(bool isCompleted, int taskId) {
    return Transform.scale(
      scale: 2,
      child: Checkbox(
        value: isCompleted,
        onChanged: (value) {
          BlocProvider.of<SpecificTaskBloc>(context)
              .add(ToggleSpecificTask(taskId));
        },
      ),
    );
  }

  _buildIsComplete(bool isCompleted) {
    if (isCompleted) {
      return Text(
        'Task completed',
        style: FONT_CONST.TODO_DESC_24,
      );
    } else {
      return Text(
        'Upcoming task',
        style: FONT_CONST.TODO_DESC_24,
      );
    }
  }

  _buildTitle(String title) {
    return Text(
      title,
      style: FONT_CONST.BOLD_DEFAULT_26,
    );
  }

  _buildDescription(String description) {
    return Text(
      description,
      style: FONT_CONST.TASK_REGULAR,
    );
  }

  _buildDueDate(String dueDate) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    var inputDate = inputFormat.parse(dueDate);

    var outputFormat = DateFormat('EEEE, MMM d');
    var outputDate = outputFormat.format(inputDate);

    return Text(
      'Due on $outputDate',
      style: FONT_CONST.DUE_DATE_REGULAR_FILLED,
    );
  }
}
