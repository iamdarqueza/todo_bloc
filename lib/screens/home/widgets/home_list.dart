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
  late HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(LoadHome());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, homeState) {
      if (homeState is HomeLoaded) {
        var incompleteTasks = homeState.incompleteTaskResponse;
        var completedTasks = homeState.completedTaskResponse;
        print('LIST ${incompleteTasks.length}');
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
                      Text('Todos:', style: FONT_CONST.MEDIUM_DEFAULT_18),
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
                  var task = incompleteTasks[index];

                  return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) {
                        BlocProvider.of<HomeBloc>(context)
                            .add(RemoveTask(task.id ?? 0));
                      },
                      background: Container(
                        color: Colors.red,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.centerRight,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: TaskWidget(
                        task: task,
                      ));
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Completed:', style: FONT_CONST.MEDIUM_DEFAULT_18),
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
                  var task = completedTasks[index];

                  return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) {
                        BlocProvider.of<HomeBloc>(context)
                            .add(RemoveTask(task.id ?? 0));
                      },
                      background: Container(
                        color: Colors.red,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.centerRight,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: TaskWidget(
                        task: task,
                      ));
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
      return Center(child: Text(''));
    });
  }

  // refreshState() {
  //  homeBloc.add
  // }
}
