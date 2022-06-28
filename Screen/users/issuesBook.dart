// ignore: file_names
// ignore: file_names
// ignore_for_file: prefer_const_constructors, file_names
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:library_management/method/studentData.dart';
import 'package:library_management/widget/appbar.dart';
import 'package:library_management/widget/textfieldColor.dart';

class IssuedBooks extends StatefulWidget {
  StudentData user;
  IssuedBooks({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _IssuedBooksState createState() => _IssuedBooksState();
}

class _IssuedBooksState extends State<IssuedBooks> {
  var bookKeys;
  var title = "Issue Books";
  var ref;
  var reference;
  final DatabaseReference _reference = FirebaseDatabase.instance.reference();

  @override
  initState() {
    super.initState();
    reference =
        _reference.child("Student").child("${widget.user.key}").child("Issue");
    ref = reference.orderByChild("BookName");
  }

  Widget issueBooks({required Map books, required BuildContext context}) {
    return Container(
      height: 182,
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      color: Colors.white,
      child: Card(
        elevation: 5,
        shadowColor: Colors.grey,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: books["profile"] != null
                      ? Image.network(books["profile"])
                      : Icon(Icons.image_outlined),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width - 158,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.indigo,
                            size: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 213,
                            child: Text(
                              books["BookName"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.indigo[900], fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.blue,
                            size: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 213,
                            child: Text(
                              books["BookAuthor"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.indigo[900], fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 213,
                            child: Text(
                              books["BookAccount"],
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.indigo[900], fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    //  Userdata user = new Userdata(books["BookName"], books["BookAuthor"], books["BookAccount"],books["BookDiscription"],books["profile"]);

                    showBookDetails(books, context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.person,
                        color: Colors.indigo,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ],
                  ),
                ),
                //   SizedBox(width: 10,),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           UpdateBook(bookKey: bookKeys["key"])),
                    //      );
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.edit,
                        color: Colors.blueAccent,
                      ),
                      Text(
                        "Edit",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //   deleteBook(books, context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red[800],
                      ),
                      Text(
                        "delet",
                        style: TextStyle(color: Colors.red[800]),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var a,b,c,d;
    // var title = "Student detail";
    return Scaffold(
      appBar: appbar(title, context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // FloatingActionButton(
            //   child: Text("Add book"),
            //   onPressed: () {
            //     displayBook(context);
            //   },
            // ),

            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  bookKeys = snapshot.value;
                  bookKeys["key"] = snapshot.key;
                  return issueBooks(books: bookKeys, context: context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

//----------------------------------------Show book Details-------------------------------//
  showBookDetails(Map bookDetails, BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: false,
            title: Image.network(bookDetails["profile"]),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text("Book Name:  ${bookDetails['BookName']} "),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.indigo,
                  ),
                  Flexible(
                    child: Text("Author Name:  ${bookDetails['BookAuthor']} "),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.indigo,
                  ),
                  Flexible(
                    child:
                        Text("Account Number: ${bookDetails['BookAccount']} "),
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.indigo,
                  ),
                  Flexible(
                    child:
                        Text("Discription: ${bookDetails['BookDiscription']} "),
                  ),
                ]),
            actions: [
              Container(
                width: 100,
                child: ElevatedButton(
                    style: buttonstyle(),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.indigo[900],
                        ),
                        Text(
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
}
