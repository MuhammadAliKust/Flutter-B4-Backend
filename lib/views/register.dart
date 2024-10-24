import 'package:flutter/material.dart';
import 'package:flutter_b4/models/user.dart';
import 'package:flutter_b4/services/auth.dart';
import 'package:flutter_b4/services/user.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController pwdController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
          ),
          TextField(
            controller: emailController,
          ),
          TextField(
            controller: addressController,
          ),
          TextField(
            controller: phoneController,
          ),
          TextField(
            controller: pwdController,
          ),
          ElevatedButton(
              onPressed: () async {
                if (emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Email cannot be empty.")));
                  return;
                }
                if (pwdController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password cannot be empty.")));
                  return;
                }
                try {
                  isLoading = true;
                  setState(() {});
                  await AuthServices()
                      .registerUser(
                          email: emailController.text,
                          password: pwdController.text)
                      .then((val) async {
                    await UserServices()
                        .createUser(UserModel(
                            docId: val!.uid.toString(),
                            email: emailController.text,
                            phoneNumber: phoneController.text,
                            name: nameController.text,
                            address: addressController.text,
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
                                  Text("User has been registered successfully"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Okay"))
                              ],
                            );
                          });
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
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text("Register User"))
        ],
      ),
    );
  }
}
