import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/new_task/bloc/bloc.dart';
import 'package:todo_bloc/utils/color_constant.dart';
import 'package:todo_bloc/utils/default_button.dart';
import 'package:todo_bloc/utils/dialog.dart';
import 'package:todo_bloc/utils/size_config.dart';

class NewTaskForm extends StatefulWidget {
  @override
  _NewTaskFormState createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  late NewTaskBloc newTaskBloc;

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();

  bool isShowPassword = false;
  bool isShowConfirmPassword = false;

  @override
  void initState() {
    newTaskBloc = BlocProvider.of<NewTaskBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }

  bool get isPopulated =>
      taskNameController.text.isNotEmpty &&
      taskDescriptionController.text.isNotEmpty;

  bool isAddTaskButtonEnabled() {
    return isPopulated;
  }

  void onAddTask() {
    if (isAddTaskButtonEnabled()) {
      Task newTask = Task(title: taskNameController.text, description: taskDescriptionController.text, dateCreated: '', dueDate: '');
      newTaskBloc.add(AddTask(newTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewTaskBloc, NewTaskState>(
      listener: (context, state) {
        /// Success
        if (state.isSuccess) {
          UtilDialog.hideWaiting(context);
          UtilDialog.showSuccess(context, 'You have added a new task');
        }

        /// Failure
        if (state.isFailure) {
          UtilDialog.hideWaiting(context);
          UtilDialog.showInformation(context, content: state.message);
        }

        /// Adding task
        if (state.isSubmitting) {
          UtilDialog.showWaiting(context);
        }
      },
      child: BlocBuilder<NewTaskBloc, NewTaskState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultPadding,
              vertical: SizeConfig.defaultSize * 3,
            ),
            child: Form(
              child: Column(
                children: <Widget>[
                  _buildTaskNameInput(),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  _buildTaskDescriptionInput(),
                  SizedBox(height: SizeConfig.defaultSize * 2),
                  _buildButtonAddTask(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build content
  _buildTaskNameInput() {
    return TextFormField(
      controller: taskNameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
              hintText: 'Enter task name',
              filled: true,
              fillColor: Colors.grey[200], // Background color
              border: InputBorder.none, // Remove the border
            ),
    );
  }


  _buildTaskDescriptionInput() {
    return TextFormField(
      controller: taskDescriptionController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
              hintText: 'Enter description',
              filled: true,
              fillColor: Colors.grey[200], // Background color
              border: InputBorder.none, // Remove the border
            ),
    );
  }


  _buildButtonAddTask() {
    return DefaultButton(
      child: Text(
        'ADD TASK',
        style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                color: Colors.green,
              ),
      ),
      onPressed: onAddTask,
     backgroundColor: isAddTaskButtonEnabled()
          ? COLOR_CONST.primaryColor
          : COLOR_CONST.cardShadowColor,
    );
  }
}
