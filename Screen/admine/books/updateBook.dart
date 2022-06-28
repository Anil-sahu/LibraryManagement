// ignore_for_file: file_names, sized_box_for_whitespace, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/method/variables/globalVariable.dart';
import 'package:library_management/widget/appbar.dart';
import 'package:library_management/widget/textfieldColor.dart';

class UpdateBook extends StatefulWidget {
  var bookKey;
  AdminData admData;
  UpdateBook({Key? key, this.bookKey, required this.admData}) : super(key: key);
  @override
  _UpdateBookState createState() => _UpdateBookState();
}

class _UpdateBookState extends State<UpdateBook> {
  var bookNameController = TextEditingController();
  var bookAuthorNameController = TextEditingController();
  var bookAccountNumberController = TextEditingController();
  var bookDiscriptionController = TextEditingController();
  var labeltext = "enter";
  var hinttext = "name";
  var icons = Icons.person;
  var title = "Update books Details";
  var book;

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
        .collection("book")
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
    Map<String, dynamic> _book = {
      "BookName": bookNameController.text,
      "BookAuthor": bookAuthorNameController.text,
      "BookAccount": bookAccountNumberController.text,
      "BookDiscription": bookDiscriptionController.text,
    };
    FirebaseFirestore.instance
        .collection("Admin")
        .doc(widget.admData.key)
        .collection("book")
        .doc(widget.bookKey)
        .update(_book)
        .whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(" Update successFul"),
      ));
    });
  }
}
