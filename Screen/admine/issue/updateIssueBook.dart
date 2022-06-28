// ignore_for_file: file_names, sized_box_for_whitespace, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/method/studentData.dart';
import 'package:library_management/method/variables/globalVariable.dart';
import 'package:library_management/widget/appbar.dart';
import 'package:library_management/widget/textfieldColor.dart';

class UpdateIssueBook extends StatefulWidget {
  var bookKey;
  StudentData user;
  AdminData admData;
  UpdateIssueBook(
      {Key? key, this.bookKey, required this.user, required this.admData})
      : super(key: key);
  @override
  _UpdateIssueBookState createState() => _UpdateIssueBookState();
}

class _UpdateIssueBookState extends State<UpdateIssueBook> {
  var bookNameController = TextEditingController();
  var bookAuthorNameController = TextEditingController();
  var bookAccountNumberController = TextEditingController();
  var bookDiscriptionController = TextEditingController();
  var charge = TextEditingController();
  var labeltext = "enter";
  var hinttext = "name";
  var icons = Icons.person;
  var title = "Update books Details";
  var book;

  var now = DateTime.now();
  var formatter = DateFormat('dd-MM-yy');
  var startDate;

  @override
  initState() {
    super.initState();

    getBookDetail();
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
                      child: Image.network(bookUrl, height: 100, width: 100),
                    ),
                    onTap: () {},
                  ),
                  TextField(
                    controller: bookNameController,
                    decoration: textfield(
                        booklabel, bookhint, bookIcon, bookNameController),
                    onChanged: (_value) {
                      setState(() {
                        bookNameController.text = _value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: bookAuthorNameController,
                    decoration: textfield(bookAuthor, bookAuthorhint, usericon,
                        bookAuthorNameController),
                    onChanged: (_value) {
                      setState(() {
                        bookAuthorNameController.text = _value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: bookAccountNumberController,
                    decoration: textfield(bookAccountlabel, bookAccounthint,
                        bookAccicon, bookAccountNumberController),
                    onChanged: (_value) {
                      setState(() {
                        bookAccountNumberController.text = _value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    textInputAction: TextInputAction.newline,
                    controller: bookDiscriptionController,
                    decoration: textfield(discriptionlabel, discriptionhint,
                        bookdisicon, bookDiscriptionController),
                    onChanged: (_value) {
                      setState(() {
                        bookDiscriptionController.text = _value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 160,
                        child: TextField(
                          controller: charge,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.money),
                              hintText: "late charge/day",
                              labelText: "Late"),
                          onChanged: (value) {
                            charge.text = value;
                          },
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          endDate != null
                              ? Text(endDate.toString(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 20))
                              : const Text(
                                  "Picke Submit Date",
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16),
                                ),
                          IconButton(
                              onPressed: () {
                                _presentDatePicker();
                              },
                              icon: const Icon(
                                FontAwesomeIcons.calendarTimes,
                                color: Colors.indigo,
                              )),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
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

  getBookDetail() async {
    final _firestore = FirebaseFirestore.instance;
    _firestore
        .collection("Admin")
        .doc(widget.admData.key)
        .collection("student")
        .doc(widget.user.key)
        .collection("borrow")
        .doc(widget.bookKey)
        .get()
        .then((value) {
      var book = value.data();

      bookNameController.text = book!["BookName"];
      bookAuthorNameController.text = book["BookAuthor"];
      bookAccountNumberController.text = book["BookAccount"];
      bookDiscriptionController.text = book["BookDiscription"];
    });
  }

  uploadImage(BuildContext context) async {
    startDate = formatter.format(now);
    Map<String, dynamic> _book = {
      "BookName": bookNameController,
      "BookAuthor": bookAuthorNameController,
      "BookAccount": bookAccountNumberController,
      "BookDiscription": bookDiscriptionController,
      "StartDate": startDate,
      "EndDate": endDate,
      "charge/day": charge.text,
    };
    FirebaseFirestore.instance
        .collection("Admin")
        .doc(widget.admData.key)
        .collection("student")
        .doc(widget.user.key)
        .collection("borrow")
        .doc(widget.bookKey)
        .update(_book)
        .whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(" ReIssue  successFul"),
      ));
    });
  }

  var endDate;

  void _presentDatePicker() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yy');

    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2050))
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        endDate = formatter.format(pickedDate);
      });
    });
  }
}
