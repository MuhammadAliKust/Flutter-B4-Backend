import 'package:flutter/material.dart';
import 'package:flutter_b4/models/task.dart';
import 'package:flutter_b4/services/task.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: StreamProvider.value(
          value: TaskServices().getAllTasks(),
          initialData: [TaskModel()],
          builder: (context, child) {
            List<TaskModel> allTaskList = context.watch<List<TaskModel>>();
            return StreamProvider.value(
                value: TaskServices().getCompletedTasks(),
                initialData: [TaskModel()],
                builder: (context, child) {
                  List<TaskModel> completedTaskList =
                      context.watch<List<TaskModel>>();
                  return StreamProvider.value(
                      value: TaskServices().getInCompletedTasks(),
                      initialData: [TaskModel()],
                      builder: (context, child) {
                        List<TaskModel> inCompletedTaskList =
                            context.watch<List<TaskModel>>();
                        return Column(
                          children: [
                            ListTile(
                              title: Text("Total Tasks"),
                              subtitle: Text(allTaskList.length.toString()),
                            ),
                            ListTile(
                              title: Text("Total Completed Tasks"),
                              subtitle:
                                  Text(completedTaskList.length.toString()),
                            ),
                            ListTile(
                              title: Text("Total InCompleted Tasks"),
                              subtitle:
                                  Text(inCompletedTaskList.length.toString()),
                            ),
                          ],
                        );
                      });
                });
          }),
    );
  }
}
