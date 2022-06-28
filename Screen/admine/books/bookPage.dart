// ignore_for_file: file_names, prefer_typing_uninitialized_variables, must_be_immutable, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/method/variables/globalVariable.dart';
import 'package:library_management/widget/textfieldColor.dart';

import 'addBook.dart';
import 'updateBook.dart';

class BookPage extends StatefulWidget {
  AdminData adminData;
  var SearchController = "";
  BookPage({Key? key, required this.SearchController, required this.adminData})
      : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  var bookKeys;
  var title = "Books";

  @override
  initState() {
    super.initState();
  }

  Widget booklist(
      {required Map books, required BuildContext context, required key}) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      color: Colors.white,
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.indigo, width: 1),
        ),
        elevation: 5,
        shadowColor: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image.network(bookUrl, height: 145, width: 140),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width - 178,
                  child: ListView(
                    shrinkWrap: true,
                    itemExtent: 40,
                    children: [
                      ListTile(
                        title: const Text("Book Name"),
                        subtitle: Text(books["BookName"]),
                      ),
                      ListTile(
                        title: const Text("Book Author"),
                        subtitle: Text(books["BookAuthor"]),
                      ),
                      ListTile(
                        title: const Text("Book Account"),
                        subtitle: Text(books["BookAccount"]),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: 5,
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_vert))),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.indigo[900],
                border: Border.all(width: 1, color: Colors.indigo),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     //  Userdata user = new Userdata(books["BookName"], books["BookAuthor"], books["BookAccount"],books["BookDiscription"],books["profile"]);

                  //     showBookDetails(books, context);
                  //   },
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: const [
                  //       Icon(
                  //         Icons.person,
                  //         color: Colors.white,
                  //       ),
                  //       Text(
                  //         "Profile",
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //   SizedBox(width: 10,),
                  IconButton(
                      focusColor: Colors.yellow,
                      hoverColor: Colors.yellowAccent,
                      highlightColor: Colors.blue,
                      color: Colors.white,
                      onPressed: () {
                        showBookDetails(books, context);
                      },
                      icon: const Icon(
                        FontAwesomeIcons.book,
                        size: 16,
                      )),
                  IconButton(
                      focusColor: Colors.yellow,
                      hoverColor: Colors.yellowAccent,
                      highlightColor: Colors.blue,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateBook(
                                    bookKey: key,
                                    admData: widget.adminData,
                                  )),
                        );
                      },
                      icon: const Icon(
                        FontAwesomeIcons.edit,
                        size: 16,
                      )),

                  IconButton(
                      focusColor: Colors.yellow,
                      hoverColor: Colors.yellowAccent,
                      highlightColor: Colors.blue,
                      color: Colors.white,
                      onPressed: () {
                        deleteBooks(context, books["BookName"], key);
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 18,
                      )),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => UpdateBook(
                  //                 bookKey: key,
                  //                 admData: widget.adminData,
                  //               )),
                  //     );
                  //   },
                  //   child: Row(
                  //     children: const [
                  //       Icon(
                  //         Icons.edit,
                  //         color: Colors.white,
                  //       ),
                  //       Text(
                  //         "Edit",
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // GestureDetector(
                  //   onTap: () {
                  //     deleteBooks(context, books["BookName"], key);
                  //   },
                  //   child: Row(
                  //     children: const [
                  //       Icon(
                  //         Icons.delete,
                  //         color: Colors.white,
                  //       ),
                  //       Text(
                  //         "delet",
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.white54,
                      ),

                      //width: MediaQuery.of(context).size.width - 213,
                      Text(
                        books["Date"],
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> bookcollection = FirebaseFirestore.instance
        .collection("Admin")
        .doc(widget.adminData.key)
        .collection("book")
        .snapshots();
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: bookcollection,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> bookdata =
                        document.data()! as Map<String, dynamic>;
                    var key = document.id;

                    if (bookdata["BookName"]
                            .toLowerCase()
                            .contains(widget.SearchController) ||
                        bookdata["BookAccount"]
                            .toLowerCase()
                            .contains(widget.SearchController) ||
                        bookdata["BookAuthor"]
                            .toLowerCase()
                            .contains(widget.SearchController)) {
                      return booklist(
                          books: bookdata, context: context, key: key);
                    } else {
                      return Text("");
                    }

                    //return booklist(books: book, context: context, key: key);
                  }).toList(),
                );
              }
              return const Text("No data");
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        tooltip: "AddBook",
        heroTag: const Text("AddBooks"),
        onPressed: () {
          var category = "No";
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddBook(
                        categories: category,
                        admindata: widget.adminData,
                      )));
        },
        child: const Icon(Icons.person_add_alt),
      ),
    );
  }

  deleteBooks(context, String name, key) async {
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
                          .doc(widget.adminData.key)
                          .collection("book")
                          .doc(key)
                          .delete()
                          .whenComplete(
                            () => ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              duration: const Duration(seconds: 3),
                              content: Text("$name have deleted successFully"),
                            )),
                          );
                      Navigator.of(context).pop();
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

  // Future<void> _delete(String ref) async {
  //   await storage.ref(ref).delete();
  //   // Rebuild the UI
  //   setState(() {});
  // }

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
}
