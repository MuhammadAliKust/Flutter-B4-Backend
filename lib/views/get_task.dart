import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b4/models/task.dart';
import 'package:flutter_b4/services/task.dart';
import 'package:flutter_b4/views/create_task.dart';
import 'package:provider/provider.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateTaskView()));
        },
        label: Text("Add Task"),
        icon: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: TaskServices().getAllTasks(),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(taskList[i].title.toString()),
                  subtitle: Text(taskList[i].description.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await TaskServices()
                                .deleteTask(taskList[i].docId.toString());
                          },
                          icon: Icon(Icons.delete)),
                      CupertinoSwitch(
                          value: taskList[i].isCompleted!,
                          onChanged: (val) async {
                            await TaskServices().markTaskAsComplete(
                                taskList[i].docId.toString());
                          })
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
