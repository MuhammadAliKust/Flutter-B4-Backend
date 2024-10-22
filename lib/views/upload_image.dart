import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b4/models/task.dart';
import 'package:flutter_b4/services/task.dart';
import 'package:flutter_b4/services/upload_file_services.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageView extends StatefulWidget {
  UploadImageView({super.key});

  @override
  State<UploadImageView> createState() => _UploadImageViewState();
}

class _UploadImageViewState extends State<UploadImageView> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
      ),
      body: Column(
        children: [
          if (image != null) ...[
            Image.file(
              image!,
              height: 200,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ],
          ElevatedButton(
              onPressed: () {
                ImagePicker imagePicker = ImagePicker();
                imagePicker
                    .pickImage(
                        source: ImageSource.camera,
                        preferredCameraDevice: CameraDevice.rear)
                    .then((val) {
                  image = File(val!.path);
                  setState(() {});
                });
              },
              child: Text("Pick Image")),
          ElevatedButton(
              onPressed: () {
                if (image == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Kindly pick image.")));
                  return;
                }
                try {
                  UploadFileServices().getUrl(image).then((fileUrl) async {
                    TaskServices().createTask(TaskModel(
                        title: 'Image Task',
                        description: 'Image Description',
                        createdAt: DateTime.now().millisecondsSinceEpoch,
                        isCompleted: false,
                        image: fileUrl));
                  });
                } catch (e) {
                  log(e.toString());
                }
              },
              child: Text("Upload Image")),
        ],
      ),
    );
  }
}
