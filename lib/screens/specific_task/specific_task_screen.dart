import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/specific_task/widgets/specific_task_list.dart';
import 'package:todo_bloc/screens/specific_task/bloc/bloc.dart';
import 'package:todo_bloc/screens/update_task/update_task_screen.dart';
import 'package:todo_bloc/utils/color_constant.dart';
import 'package:todo_bloc/utils/default_button.dart';
import 'package:todo_bloc/utils/font_constant.dart';
import 'package:todo_bloc/utils/size_config.dart';

class SpecificTaskScreen extends StatelessWidget {
  final Task task;

  const SpecificTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpecificTaskBloc()..add(LoadTask(task.id ?? 0)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                'Task',
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
              children: [SpecificTaskList(task: task)],
            ),
            bottomNavigationBar: _buildUpdateButton(context),
          );
        },
      ),
    );
  }

  Widget _buildUpdateButton(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(SizeConfig.defaultSize * 2, 10,
          SizeConfig.defaultSize * 2, SizeConfig.defaultSize * 2),
      child: DefaultButton(
        child: Text(
          'UPDATE',
          style: FONT_CONST.BOLD_WHITE_18,
        ),
        onPressed: () {
           Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UpdateTaskScreen(task: task,)));
        },
        backgroundColor: COLOR_CONST.primaryColor,
      ),
    );
  }
}
