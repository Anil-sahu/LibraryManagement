// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/method/studentData.dart';
import 'package:library_management/method/variables/globalVariable.dart';
import 'package:library_management/widget/textfieldColor.dart';

class IssueBook extends StatefulWidget {
  StudentData stdData;
  AdminData adminData;
  IssueBook({Key? key, required this.stdData, required this.adminData})
      : super(key: key);

  @override
  _IssueBookState createState() => _IssueBookState();
}

// ignore: duplicate_ignore
class _IssueBookState extends State<IssueBook> {
  TextEditingController bookNameController = TextEditingController();
  TextEditingController bookAuthorNameController = TextEditingController();
  TextEditingController bookAccountNumberController = TextEditingController();
  TextEditingController bookDiscriptionController = TextEditingController();
  TextEditingController charge = TextEditingController();
  var title = "Issue books";

  CollectionReference admincollection =
      FirebaseFirestore.instance.collection("Admin");
  var now = DateTime.now();
  var formatter = DateFormat('dd-MM-yy');
  var startDate;
  uploadImage(BuildContext context, index) async {
    startDate = formatter.format(now);
    Map<String, dynamic> _bookissue = {
      "BookName": bookNameController.text,
      "BookAuthor": bookAuthorNameController.text,
      "BookAccount": bookAccountNumberController.text,
      "BookDiscription": bookDiscriptionController.text,
      "StartDate": startDate,
      "EndDate": endDate,
      "charge/day": charge.text,
      "StudentKey": widget.stdData.key,
      "isReturn": false,
    };
    admincollection
        .doc(widget.adminData.key)
        .collection("student")
        .doc(widget.stdData.key)
        .collection("borrow")
        .add(_bookissue)
        .then((value) => Navigator.of(context).pop());
  }

  // Future<void> _delete(String ref) async {
  //   await storage.ref(ref).delete();
  //   // Rebuild the UI
  //   setState(() {});
  // }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appbar(title),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
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
                          child: Image.network(bookUrl)),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      //    controller: bookNameController,
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
                      //    controller: bookAuthorNameController,
                      decoration: textfield(bookAuthor, bookAuthorhint,
                          usericon, bookAuthorNameController),
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
                      //  controller: bookAccountNumberController,
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
                      // controller: bookDiscriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      textInputAction: TextInputAction.newline,
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
                              "   Add",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          int index = 0;
                          uploadImage(context, index);
                          admincollection
                              .doc(widget.adminData.key)
                              .collection("student")
                              .doc(widget.stdData.key)
                              .update(({
                                "Issuebooks": (++widget.stdData.issuebook)
                              }));
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

  //--------------------------Show book Details------------------------------------//
  showBookDetails(Map bookDetails, BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: false,
            title: Image.network(bookUrl),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text("Book Name:  ${bookDetails['IssueDate']} "),
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.indigo,
                  ),
                  Flexible(
                    child: Text("Book Name:  ${bookDetails['BookName']} "),
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.indigo,
                  ),
                  Flexible(
                    child: Text("Author Name:  ${bookDetails['BookAuthor']} "),
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.indigo,
                  ),
                  Flexible(
                    child:
                        Text("Account Number: ${bookDetails['BookAccount']} "),
                  ),
                  // ignore: prefer_const_constructors
                  Divider(
                    height: 2,
                    color: Colors.indigo,
                  ),
                  Flexible(
                    child:
                        Text("Discription: ${bookDetails['BookDiscription']} "),
                  ),
                ]),
            actions: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                    style: buttonstyle(),
                    onPressed: () {
                      //   _delete(ref);
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.indigo[900],
                        ),
                        const Text(
                          "Back",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ],
                    )),
              ),
            ],
          );
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
