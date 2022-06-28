// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:library_management/Screen/users/usersRout.dart';
import 'package:library_management/method/studentData.dart';
import 'package:library_management/method/variables/globalVariable.dart';
import 'package:library_management/widget/circular_Loding_bar.dart';

class UserSignIn {
  var id;
  var student;
  final _auth = FirebaseAuth.instance;
  var ref = FirebaseDatabase.instance.reference();
  userSignIn(BuildContext context, username, password) async {
    try {
      if (loading == true) progressBar(context);
      await _auth
          .signInWithEmailAndPassword(email: username, password: password)
          .then((value) {
        id = _auth.currentUser!.uid;
      }).whenComplete(() {
        ref.child("Student").child(id).onValue.listen((value) {
          student = value.snapshot.value;
          StudentData stdData = StudentData(
              name: student["name"],
              email: student["email"],
              mobile_number: student["mobile"],
              password: student["password"],
              student_id: student["studentId"],
              issuebook: student["Issuebooks"],
              returnbook: student["Returnbook"],
              key: id);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => userRout(
                      studentData: stdData,
                    )),
          );
          loading = false;
        });
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      signInError(context, e.code);
    }
  }

  signInError(BuildContext context, error) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(error),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("ok"))
            ],
          );
        });
    //  return error;
  }
}
