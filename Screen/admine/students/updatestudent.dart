import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/method/variables/globalVariable.dart';
import 'package:library_management/widget/appbar.dart';
import 'package:library_management/widget/textfieldColor.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class UpdateStudent extends StatefulWidget {
  var studentKey;
  AdminData admindata;
  UpdateStudent({this.studentKey, required this.admindata});
  @override
  _UpdateStudentState createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  var nameController = TextEditingController();
  var studentIdController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var title = "Update User Detail";

  var student;
  @override
  initState() {
    super.initState();

    getStudentDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title, context),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: Image.network(userUrl, height: 100, width: 100)),
                    onTap: () {},
                  ),
                  TextField(
                    controller: nameController,
                    decoration: textfield(
                        studentIdlabel, studenthint, usericon, nameController),
                    onChanged: (_value) {
                      setState(() {
                        nameController.text = _value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: studentIdController,
                    decoration: textfield(studentIdlabel, studentidhint, idicon,
                        studentIdController),
                    onChanged: (_value) {
                      setState(() {
                        studentIdController.text = _value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: mobileController,
                    decoration: textfield(
                        mobilelabel, mobilehint, phonIcon, mobileController),
                    onChanged: (_value) {
                      setState(() {
                        emailController.text = _value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: textfield(
                        emaillabel, emailhint, emailicon, emailController),
                    onChanged: (_value) {
                      setState(() {
                        emailController.text = _value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordController,
                    readOnly: true,
                    decoration: textfield(
                        passlabel, passhint, passicon, passwordController),
                    onChanged: (_value) {
                      setState(() {
                        passwordController.text = _value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 150,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: buttonstyle(),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.update,
                              color: Colors.white,
                            ),
                            Text("  Update",
                                style: TextStyle(color: Colors.white))
                          ]),
                      onPressed: () {
                        uploadImage(context);
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getStudentDetails() async {
    final _firestore = FirebaseFirestore.instance;
    _firestore.collection("student").doc(widget.studentKey).get().then((value) {
      var student = value.data();

      setState(() {
        nameController.text = student!["name"];
        studentIdController.text = student["studentId"];
        mobileController.text = student["mobile"];
        emailController.text = student["email"];
        passwordController.text = student["password"];
      });
    });
  }

  uploadImage(BuildContext context) async {
    Map<String, dynamic> _students = {
      "name": nameController.text,
      "studentId": studentIdController.text,
      "mobile": mobileController.text,
      "email": emailController.text,
      "password": passwordController.text,
    };
    final _firestore = FirebaseFirestore.instance;
    _firestore.collection("student").doc(widget.studentKey).update(_students);
    _firestore
        .collection("Admin")
        .doc(widget.admindata.key)
        .collection("student")
        .doc(widget.studentKey)
        .update(_students)
        .whenComplete(() => Navigator.of(context).pop());
  }
}
