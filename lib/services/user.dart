import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_b4/models/user.dart';

class UserServices {
  ///Create User
  Future createUser(UserModel model) async {
    await FirebaseFirestore.instance
        .collection('userCollection')
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }
}
