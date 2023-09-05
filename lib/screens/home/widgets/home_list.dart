import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/screens/home/bloc/bloc.dart';
import 'package:todo_bloc/screens/home/widgets/home_empty_list.dart';
import 'package:todo_bloc/screens/home/widgets/task_widget_card.dart';
import 'package:todo_bloc/utils/font_constant.dart';
import 'package:todo_bloc/utils/loading.dart';

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
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

        if (incompleteTasks.isEmpty && completedTasks.isEmpty) {
          return HomeEmptyList();
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Incomplete Tasks:',
                          style: FONT_CONST.MEDIUM_DEFAULT_18),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        color: Colors.black12,
                        height: 1,
                        width: double.infinity,
                      ),
                    ]),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: incompleteTasks.length,
                itemBuilder: (context, index) {
                  final task = incompleteTasks[index];
                  return TaskWidget(
                    task: task,
                  );
                },
              ),

               Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Completed Tasks:',
                          style: FONT_CONST.MEDIUM_DEFAULT_18),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        color: Colors.black12,
                        height: 1,
                        width: double.infinity,
                      ),
                    ]),
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  final task = completedTasks[index];
                  return TaskWidget(
                    task: task,
                  );
                },
              )
            ],
          );
        }
      }

      if (homeState is HomeLoading) {
        return Loading();
      }
      if (homeState is HomeLoadFailure) {
        return Center(child: Text(homeState.error));
      }
      return Center(child: Text("Something went wrong."));
    });
  }
}
