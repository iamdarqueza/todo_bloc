import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/data/local/task.dart';
import 'package:todo_bloc/screens/home/bloc/bloc.dart';
import 'package:todo_bloc/screens/home/widgets/home_empty_list.dart';
import 'package:todo_bloc/screens/home/widgets/task_widget_card.dart';
import 'package:todo_bloc/utils/font_constant.dart';
import 'package:todo_bloc/utils/loading.dart';
import 'package:todo_bloc/utils/size_config.dart';

class HomeHeader extends StatefulWidget {
  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
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
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, homeState) {
      if (homeState is HomeLoaded) {
        final incompleteTasks = homeState.incompleteTaskResponse;
        final completedTasks = homeState.completedTaskResponse;
        final totalTasks = incompleteTasks.length + completedTasks.length;
        final progressValue = completedTasks.length / totalTasks;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: SizeConfig.defaultSize * 3,
            bottom: SizeConfig.defaultSize * 2,
            right: SizeConfig.defaultSize * 2,
            left: SizeConfig.defaultSize * 2,
          ),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Todos',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Syne',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _buildTextTask(incompleteTasks, completedTasks),
              SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                value: progressValue, // Set the progress value (0.0 to 1.0)
                backgroundColor: Colors.grey[300], // Background color
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFF2CAE76)), // Progress color
              ),
            ],
          ),
        );
      }

      return Center(child: Text("Something went wrong."));
    });
  }

  Widget _buildTextTask(List<Task> incomplete, List<Task> completed) {
    if (incomplete.isEmpty && completed.isEmpty) {
      return Text(
        'No Tasks available',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      );
    } else {
      return Text(
        '${incomplete.length} Tasks available',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      );
    }
  }
}
