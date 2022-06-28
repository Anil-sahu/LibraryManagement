// ignore_for_file: file_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/method/variables/globalVariable.dart';
import 'package:library_management/widget/textfieldColor.dart';

import 'package:path/path.dart' as path;

class AddBook extends StatefulWidget {
  AdminData admindata;
  String categories;
  AddBook({Key? key, required this.categories, required this.admindata})
      : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  String bookNameController = "";
  String bookAuthorNameController = "";
  var bookAccountNumberController;
  String bookDiscriptionController = "";
  var title = "Add New User";

  CollectionReference admincollection =
      FirebaseFirestore.instance.collection("Admin");

  uploadImage(BuildContext context, index) async {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yy');
    String formattedDate = formatter.format(now);

    Map<String, dynamic> _book = {
      "BookName": bookNameController,
      "BookAuthor": bookAuthorNameController,
      "Date": formattedDate,
      "Category": widget.categories,
      "BookAccount": bookAccountNumberController,
      "BookDiscription": bookDiscriptionController,
    };

    admincollection
        .doc(widget.admindata.key)
        .collection("book")
        .add(_book)
        .then((value) => Navigator.of(context).pop());
  }

  // Future<void> _delete(String ref) async {
  //   await storage.ref(ref).delete();
  //   // Rebuild the UI
  //   setState(() {});
  // }

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appbar(title),
      body: SafeArea(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.indigo),
                        ),
                        width: 100,
                        height: 100,
                        // child: _image != null
                        //     ? Image.file(
                        //         _image,
                        //         height: 100,
                        //         width: 100,
                        //       )
                        child: Image.network(
                          bookUrl,
                          height: 100,
                          width: 100,
                        ),
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      //   controller: bookNameController,
                      decoration: textfield(
                          booklabel, bookhint, bookIcon, bookNameController),
                      onChanged: (_value) {
                        setState(() {
                          bookNameController = _value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      //   controller: bookAuthorNameController,
                      decoration: textfield(bookAuthor, bookAuthorhint,
                          usericon, bookAuthorNameController),
                      onChanged: (_value) {
                        setState(() {
                          bookAuthorNameController = _value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      // controller: bookAccountNumberController,
                      decoration: textfield(bookAccountlabel, bookAccounthint,
                          bookAccicon, bookAccountNumberController),
                      onChanged: (_value) {
                        setState(() {
                          bookAccountNumberController = _value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      //  controller: bookDiscriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      textInputAction: TextInputAction.newline,
                      decoration: textfield(discriptionlabel, discriptionhint,
                          bookdisicon, bookDiscriptionController),
                      onChanged: (_value) {
                        setState(() {
                          bookDiscriptionController = _value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: 100,
                      // alignment: Alignment.center,
                      decoration: buttondecoration(),
                      child: ElevatedButton(
                        style: buttonstyle(),
                        child: Row(
                          children: const [
                            Icon(
                              FontAwesomeIcons.book,
                              color: Colors.white,
                            ),
                            Text(
                              " Add",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          int index = 0;
                          uploadImage(context, index);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
