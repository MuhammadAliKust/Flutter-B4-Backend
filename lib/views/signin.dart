import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_b4/services/auth.dart';

class SignInView extends StatefulWidget {
  SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
        title: Text("SignIn"),
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
                      .signInUser(
                          email: emailController.text,
                          password: pwdController.text)
                      .then((val) {
                    isLoading = false;
                    setState(() {});
                    if (val!.emailVerified == true) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Message"),
                              content:
                                  Text("User has been loggedIn successfully"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Okay"))
                              ],
                            );
                          });
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Message"),
                              content:
                                  Text("Kindly verify your email address."),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Okay"))
                              ],
                            );
                          });
                    }
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
                  : Text("Login User"))
        ],
      ),
    );
  }
}
