import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_management/widget/textfieldColor.dart';

deleteStudent(context, String name, admkey, stdkey, loading) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(children: [
            const Icon(
              Icons.cancel_outlined,
              color: Colors.red,
            ),
            Text("Delete $name"),
          ]),
          content: Text("Are you sure you want to delete $name"),
          actions: [
            Container(
              child: ElevatedButton(
                  style: buttonstyle(),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "No",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Container(
              child: ElevatedButton(
                  style: buttonstyle(),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("Admin")
                        .doc(admkey)
                        .collection("student")
                        .doc(stdkey)
                        .delete()
                        .whenComplete(() => Navigator.of(context).pop());
                    FirebaseFirestore.instance
                        .collection("student")
                        .doc(stdkey)
                        .delete()
                        .whenComplete(() =>
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("$name have deleted successFully"),
                            )))
                        .catchError((onError) {
                      print(onError);
                    });
                  },
                  child: loading == true
                      ? const CircularProgressIndicator(
                          backgroundColor: Colors.red,
                        )
                      : const Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        )),
            ),
          ],
        );
      });
}
