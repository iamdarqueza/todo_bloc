import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/home/bloc/home_bloc.dart';
import 'package:todo_bloc/screens/home/bloc/home_event.dart';
import 'package:todo_bloc/screens/new_task/bloc/bloc.dart';
import 'package:todo_bloc/utils/color_constant.dart';
import 'package:todo_bloc/utils/default_button.dart';
import 'package:todo_bloc/utils/dialog.dart';
import 'package:todo_bloc/utils/font_constant.dart';
import 'package:todo_bloc/utils/size_config.dart';
import 'package:intl/intl.dart';

class NewTaskForm extends StatefulWidget {
  @override
  _NewTaskFormState createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  late NewTaskBloc newTaskBloc;
  late HomeBloc homeBloc;

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final TextEditingController dueDateController = TextEditingController();

  DateTime? dueDate;

  @override
  void initState() {
    newTaskBloc = BlocProvider.of<NewTaskBloc>(context);
    homeBloc = BlocProvider.of<HomeBloc>(context);
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
      taskDescriptionController.text.isNotEmpty &&
      dueDateController.text.isNotEmpty;

  bool isAddTaskButtonEnabled() {
    return !newTaskBloc.state.isSubmitting && isPopulated;
  }

  void onAddTask() {
    if (isAddTaskButtonEnabled()) {
      Task newTask = Task(
          title: taskNameController.text,
          description: taskDescriptionController.text,
          dateCreated: '${DateTime.now()}',
          dueDate: '$dueDate');
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
                  _buildDueDateInput(),
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
      onChanged: (value) {
        newTaskBloc.add(TextFieldChanged());
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
      controller: taskDescriptionController,
      keyboardType: TextInputType.name,
      onChanged: (value) {
        newTaskBloc.add(TextFieldChanged());
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
        controller: dueDateController,
        keyboardType: TextInputType.datetime,
        onChanged: (value) {
          newTaskBloc.add(TextFieldChanged());
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
            dueDate = pickedDate;
            String formattedDate = DateFormat('EEEE, MMM d').format(pickedDate);
            setState(() {
              dueDateController.text = formattedDate;
            });
          } else {
            print("Date is not selected");
          }
        });
  }

  _buildButtonAddTask() {
    return DefaultButton(
      child: Text(
        'ADD TASK',
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
