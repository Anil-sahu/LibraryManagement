import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_management/Screen/admine/books/bookPage.dart';
import 'package:library_management/Screen/admine/books/categories.dart';
import 'package:library_management/Screen/admine/students/deletestudent.dart';
import 'package:library_management/Screen/admine/students/detailsScreen.dart';
import 'package:library_management/Screen/admine/students/studentPage.dart';
import 'package:library_management/Screen/admine/students/updatestudent.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/method/booksData.dart';
import 'package:library_management/method/studentData.dart';
import 'package:library_management/method/variables/globalVariable.dart';
import 'package:line_icons/line_icon.dart';

class SearchUser extends StatefulWidget {
  AdminData admData;
  SearchUser({Key? key, required this.admData}) : super(key: key);

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final DatabaseReference _reference = FirebaseDatabase.instance.ref();

  var searchController = "";
  var stud;
  var users;
  var books;
  var bookdata;
  var both;
  var bothdata;
  bool isSearched = false;

  Widget booklist({required Map books, required BuildContext context}) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Card(
        elevation: 5,
        shadowColor: Colors.grey,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.indigo, width: 1),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 145,
                  width: 145,
                  child: Image.network(bookUrl),
                ),
                Column(
                  children: [
                    Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert_outlined,
                            size: 16,
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width - 158,
                      child: Column(
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
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
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
                      BookData user = BookData(
                        bookName: books["BookName"],
                        bookAuthor: books["BookAuthor"],
                        bookDiscription: books["BookAccount"],

                        bookImage: books["profile"],
                        //  key: stud["key"]
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => DetailScreen(
                      //             user: user,
                      //             admData: widget.admData,
                      //           )),
                      // );
                      //  IssueBook(studentKey: stud["key"]);
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
                  GestureDetector(
                    onTap: () {
                      //  Navigator.push(context, MaterialPageRoute(builder:(context)=>IssueBook()));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateStudent(
                                  studentKey: stud["key"],
                                  admindata: widget.admData,
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
                      // deleteStudent(students, context);
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget studentlist({required Map students, required BuildContext context}) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Card(
        elevation: 5,
        shadowColor: Colors.grey,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.indigo, width: 1),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 145,
                  width: 145,
                  child: Image.network(userUrl),
                ),
                Column(
                  children: [
                    Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert_outlined,
                            size: 16,
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width - 158,
                      child: Column(
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
                                  students["name"],
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
                                  students["mobile"],
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
                                  students["email"],
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
                      StudentData user = StudentData(
                          name: students["name"],
                          email: students["email"],
                          mobile_number: students["mobile"],
                          password: students["password"],
                          student_id: students["studentId"],
                          issuebook: students["Issuebooks"],
                          returnbook: students["Returnbook"],
                          key: students["key"]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                  user: user,
                                  admData: widget.admData,
                                )),
                      );
                      //  IssueBook(studentKey: stud["key"]);
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
                  GestureDetector(
                    onTap: () {
                      //  Navigator.push(context, MaterialPageRoute(builder:(context)=>IssueBook()));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateStudent(
                                  studentKey: stud["key"],
                                  admindata: widget.admData,
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
                      deleteStudent(context, students["name"],
                          widget.admData.key, students["key"], loading);
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final Stream<QuerySnapshot> studentcollection = FirebaseFirestore.instance
        .collection("Admin")
        .doc(widget.admData.key)
        .collection("student")
        .snapshots();
    books = _reference
        .child(widget.admData.key)
        .child("Book")
        .orderByChild("BookName");
    // both = [users, books];
  }

  @override
  Widget build(BuildContext context) {
    var admcollection =
        FirebaseFirestore.instance.collection("Admin").doc(widget.admData.key);
    final Stream<QuerySnapshot> studentcollection =
        admcollection.collection("student").snapshots();
    final Stream<QuerySnapshot> bookcollection =
        admcollection.collection("book").snapshots();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          title: Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.white,
              ),
            ),
            child: TextFormField(
                decoration: const InputDecoration(
                  hintMaxLines: 1,
                  hintText: "search books and member by name ,id, author name",
                  hintStyle: TextStyle(color: Colors.white54, fontSize: 16),
                  fillColor: Colors.black12,
                  prefixText: "  ",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white54,
                  ),
                  suffixIcon: Icon(
                    Icons.close,
                    color: Colors.white54,
                  ),
                ),
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  setState(() {
                    searchController = value.toLowerCase();
                  });
                },
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),

          // centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.yellowAccent,
            indicatorWeight: 3,
            tabs: [
              Tab(
                icon: Icon(
                  FontAwesomeIcons.user,
                  color: Colors.white,
                  size: 20,
                ),
                text: "student",
              ),
              Tab(
                icon: Icon(
                  Icons.book,
                  color: Colors.white,
                  size: 20,
                ),
                text: "Books",
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          StudentPage(
              searchController: searchController, adminData: widget.admData),
          BookPage(
            SearchController: searchController,
            adminData: widget.admData,
          ),
        ]),
      ),
    );
  }
}
