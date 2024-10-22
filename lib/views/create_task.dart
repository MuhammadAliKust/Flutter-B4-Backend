import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b4/models/task.dart';

import '../services/task.dart';

class CreateTaskView extends StatefulWidget {
  CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Task"),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
          ),
          TextField(
            controller: descriptionController,
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () async {
                if (titleController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Title cannot be empty.")));
                  return;
                }
                if (descriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Description cannot be empty.")));
                  return;
                }

                try {
                  isLoading = true;
                  setState(() {});
                  await TaskServices()
                      .createTask(TaskModel(
                          title: titleController.text,
                          description: descriptionController.text,
                          userID: FirebaseAuth.instance.currentUser!.uid,
                          isCompleted: false,
                          createdAt: DateTime.now().millisecondsSinceEpoch))
                      .then((val) {
                    isLoading = false;
                    setState(() {});
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Message"),
                            content:
                                Text("Task has been created successfully."),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Okay"))
                            ],
                          );
                        });
                  });
                } catch (e) {
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const Text("Create Task"))
        ],
      ),
    );
  }
}
