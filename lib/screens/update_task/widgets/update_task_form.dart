import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/update_task/bloc/bloc.dart';
import 'package:todo_bloc/screens/update_task/bloc/update_task_bloc.dart';
import 'package:todo_bloc/screens/update_task/bloc/update_task_state.dart';
import 'package:todo_bloc/utils/color_constant.dart';
import 'package:todo_bloc/utils/default_button.dart';
import 'package:todo_bloc/utils/dialog.dart';
import 'package:todo_bloc/utils/font_constant.dart';
import 'package:todo_bloc/utils/loading.dart';
import 'package:todo_bloc/utils/size_config.dart';
import 'package:intl/intl.dart';

class UpdateTaskForm extends StatefulWidget {
  final Task task;

  const UpdateTaskForm({Key? key, required this.task}) : super(key: key);

  @override
  _UpdateTaskFormState createState() => _UpdateTaskFormState();
}

class _UpdateTaskFormState extends State<UpdateTaskForm> {
  late UpdateTaskBloc updateTaskBloc;
  late UpdateTaskFormBloc updateTaskFormBloc;


  @override
  void initState() {
    super.initState();
    updateTaskBloc = BlocProvider.of<UpdateTaskBloc>(context);
    updateTaskFormBloc = BlocProvider.of<UpdateTaskFormBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool get isPopulated =>
      updateTaskFormBloc.taskNameController.text.isNotEmpty &&
      updateTaskFormBloc.taskDescriptionController.text.isNotEmpty &&
      updateTaskFormBloc.dueDateController.text.isNotEmpty;

  bool isAddTaskButtonEnabled() {
    return !updateTaskBloc.state.isSubmitting && isPopulated;
  }

  void onAddTask() {
    Task newTask = Task(
        id: updateTaskFormBloc.id,
        title: updateTaskFormBloc.taskNameController.text,
        description: updateTaskFormBloc.taskDescriptionController.text,
        dateCreated: updateTaskFormBloc.dateCreated ?? '${DateTime.now()}',
        dueDate: '${updateTaskFormBloc.dueDate}');

    print('${newTask.id} ${newTask.dueDate} ${newTask.dateCreated}');
    updateTaskFormBloc.add(UpdateExistingTask(newTask));
    updateTaskBloc.add(UpdateExistingTask(newTask));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateTaskBloc, UpdateTaskState>(
      listener: (context, state) {
        /// Success
        if (state.isSuccess) {
          UtilDialog.hideWaiting(context);
          UtilDialog.showSuccess(context, 'You have updated a task');
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
      child: BlocBuilder<UpdateTaskFormBloc, UpdateTaskFormState>(
        builder: (context, updateTaskState) {
          if (updateTaskState is UpdateTaskFormLoaded) {
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
                    _buildTaskNameInput(),
                    SizedBox(height: SizeConfig.defaultSize),
                    _buildTaskDescriptionInput(),
                    SizedBox(height: SizeConfig.defaultSize * 2),
                    _buildDueDateInput(),
                    SizedBox(height: SizeConfig.defaultSize * 2),
                    _buildButtonAddTask(),
                  ],
                ),
              ),
            );
          }
          if (updateTaskState is UpdateTaskFormNewLoaded) {
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
                    _buildTaskNameInput(),
                    SizedBox(height: SizeConfig.defaultSize),
                    _buildTaskDescriptionInput(),
                    SizedBox(height: SizeConfig.defaultSize * 2),
                    _buildDueDateInput(),
                    SizedBox(height: SizeConfig.defaultSize * 2),
                    _buildButtonAddTask(),
                  ],
                ),
              ),
            );
          }
          if (updateTaskState is UpdateTaskFormLoading) {
            return Loading();
          }
          if (updateTaskState is UpdateTaskFormLoadFailure) {
            return Center(child: Text(updateTaskState.error));
          }
          return Center(child: Text(''));
        },
      ),
    );
  }

  /// Build content
  _buildTaskNameInput() {
    return TextFormField(
      controller: updateTaskFormBloc.taskNameController,
      keyboardType: TextInputType.name,
      onChanged: (value) {
        updateTaskBloc.add(TextFieldChanged());
      },
      style: FONT_CONST.TASK_REGULAR,
      decoration: InputDecoration(
        hintText: 'Enter task name',
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
      ),
    );
  }

  _buildTaskDescriptionInput() {
    return TextFormField(
      controller: updateTaskFormBloc.taskDescriptionController,
      keyboardType: TextInputType.name,
      onChanged: (value) {
        updateTaskBloc.add(TextFieldChanged());
      },
      maxLines: 2,
      style: FONT_CONST.TASK_REGULAR,
      decoration: InputDecoration(
        hintText: 'Enter description',
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
      ),
    );
  }

  _buildDueDateInput() {
    return TextFormField(
        controller: updateTaskFormBloc.dueDateController,
        keyboardType: TextInputType.datetime,
        onChanged: (value) {
          updateTaskBloc.add(TextFieldChanged());
        },
        maxLines: 1,
        style: FONT_CONST.DUE_DATE_REGULAR_FILLED,
        readOnly: true,
        decoration: InputDecoration(
          hintText: 'Choose due date',
          hintStyle: FONT_CONST.DUE_DATE_REGULAR_HINT,
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(), //get today's date
              firstDate: DateTime(
                  2000), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101));

          if (pickedDate != null) {
           
            String formattedDate = DateFormat('EEEE, MMM d').format(pickedDate);
            setState(() {
              updateTaskFormBloc.dueDateController.text = formattedDate;
            });
          } else {
            print("Date is not selected");
          }
        });
  }

  _buildButtonAddTask() {
    return DefaultButton(
      child: Text(
        'UPDATE TASK',
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal,
          color: isAddTaskButtonEnabled() ? Colors.white : Colors.black54,
        ),
      ),
      onPressed: onAddTask,
      backgroundColor: isAddTaskButtonEnabled()
          ? COLOR_CONST.primaryColor
          : COLOR_CONST.cardShadowColor,
    );
  }
}
