import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/method/variables/globalVariable.dart';
import 'package:library_management/widget/textfieldColor.dart';

import 'addBook.dart';
import 'updateBook.dart';

class BookCategories extends StatefulWidget {
  AdminData adminData;
  String searchController = "";
  var categories = "";
  BookCategories(
      {Key? key,
      required this.categories,
      required this.searchController,
      required this.adminData})
      : super(key: key);

  @override
  _BookCategoriesState createState() => _BookCategoriesState();
}

class _BookCategoriesState extends State<BookCategories> {
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
      height: 180,
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
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  child: Image.network(bookUrl, height: 100, width: 100),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width - 158,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.indigo,
                            size: 16,
                          ),
                          const SizedBox(
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
                          const Icon(
                            Icons.phone,
                            color: Colors.blue,
                            size: 16,
                          ),
                          const SizedBox(
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
                          const Icon(
                            Icons.email,
                            color: Colors.deepOrange,
                            size: 16,
                          ),
                          const SizedBox(
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
                              )),
                        ],
                      ),
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Colors.black54,
                            ),

                            //width: MediaQuery.of(context).size.width - 213,
                            Text(
                              books["Date"],
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
                          color: Colors.white,
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  //   SizedBox(width: 10,),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateBook(
                                  bookKey: key,
                                  admData: widget.adminData,
                                )),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        Text(
                          "Edit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      deleteBooks(context, books["BookName"], key);
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        Text(
                          "delet",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.black54,
                      ),

                      //width: MediaQuery.of(context).size.width - 213,
                      Text(
                        books["Date"],
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 1,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
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
        .where("Category", isEqualTo: widget.categories)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: Text(widget.categories),
      ),
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
                            .contains(widget.searchController) ||
                        bookdata["BookAccount"]
                            .toLowerCase()
                            .contains(widget.searchController) ||
                        bookdata["BookAuthor"]
                            .toLowerCase()
                            .contains(widget.searchController)) {
                      return booklist(
                          books: bookdata, context: context, key: key);
                    } else {
                      return Text("");
                    }

                    //return booklist(books: book, context: context, key: key);
                  }).toList(),
                );
              } else {
                return const Text("No data");
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        tooltip: "AddBook",
        heroTag: const Text("AddBooks"),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddBook(
                        categories: widget.categories,
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
