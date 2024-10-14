import 'package:flutter/material.dart';
import 'package:flutter_b4/models/task.dart';

import '../services/task.dart';

class UpdateTaskView extends StatefulWidget {
  final TaskModel model;

  UpdateTaskView({super.key, required this.model});

  @override
  State<UpdateTaskView> createState() => _UpdateTaskViewState();
}

class _UpdateTaskViewState extends State<UpdateTaskView> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    titleController =
        TextEditingController(text: widget.model.title.toString());
    descriptionController =
        TextEditingController(text: widget.model.description.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Task"),
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
                      .updateTask(TaskModel(
                          title: titleController.text,
                          description: descriptionController.text,
                          docId: widget.model.docId.toString()))
                      .then((val) {
                    isLoading = false;
                    setState(() {});
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Message"),
                            content:
                                Text("Task has been updated successfully."),
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
                  : const Text("Update Task"))
        ],
      ),
    );
  }
}
