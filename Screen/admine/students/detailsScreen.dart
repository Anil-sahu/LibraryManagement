// ignore: file_names
// ignore_for_file: prefer_const_constructors, file_names, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:library_management/Screen/admine/issue/issuBook.dart';
import 'package:library_management/Screen/admine/issue/updateIssueBook.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/method/studentData.dart';
import 'package:library_management/method/variables/globalVariable.dart';
import 'package:library_management/widget/dropdown.dart';
import 'package:library_management/widget/textfieldColor.dart';

class DetailScreen extends StatefulWidget {
  StudentData user;
  AdminData admData;

  DetailScreen({
    Key? key,
    required this.user,
    required this.admData,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var bookKeys;
  var title = "Books";
  var ref;
  var reference;
  bool isIssue = false;
  var booklength;
  var charges = 0;

  var dueBook = 0;
  var l;
  var admCollection = FirebaseFirestore.instance.collection("Admin");
  int numberofBooks = 0;

  @override
  initState() {
    super.initState();

    String studentKey = widget.user.key;

    setState(() {
      // l = totalIssueBook;
    });
  }

  var todatDate = DateFormat('dd-MM-yy').format(DateTime.now());

  Widget issueBooks(
      {required Map books, required BuildContext context, required key}) {
    bool isDue = false;
    if (books["isReturn"] == false) {
      if (todatDate.compareTo(books["EndDate"]) > 0) {
        isDue = false;
      } else {
        isDue = true;
      }
    } else {}
    if (todatDate.compareTo(books["EndDate"]) > 0) {
      isDue = false;
    } else {
      isDue = true;
    }

    var editcolor = Colors.white;
    bool isReturn = false;

    return Column(
      children: [
        Container(
          height: 250,
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          color: Colors.white,
          child: Card(
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.indigo, width: 1),
            ),
            elevation: 5,
            shadowColor: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(bookUrl, height: 145, width: 130),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1 - 178,
                      child: ListView(
                        itemExtent: 40,
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            title: Text("Book Name"),
                            subtitle: Text(
                              books["BookName"],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ListTile(
                            title: Text("Book Author"),
                            subtitle: Text(
                              books["BookAuthor"],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ListTile(
                            title: Text("Book Author"),
                            subtitle: Text(
                              books["BookAccount"],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: 10,
                        child: IconButton(
                            onPressed: () {
                              DropDownMenuButton();
                            },
                            icon: Icon(Icons.more_vert))),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                      Row(
                        children: [
                          IconButton(
                            splashColor: Colors.yellow[100],
                            highlightColor: Colors.yellowAccent,
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.solidCheckCircle,
                              color: Colors.greenAccent,
                            ),
                          ),
                          Text("Issue",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16))
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              splashColor: Colors.yellow[100],
                              highlightColor: Colors.yellowAccent,
                              onPressed: () {
                                returnBook(
                                    context,
                                    books["BookName"],
                                    books["StartBook"],
                                    books["EndBook"],
                                    isReturn,
                                    key);
                              },
                              icon: books["isReturn"] == true
                                  ? Icon(FontAwesomeIcons.solidCheckCircle,
                                      color: Colors.greenAccent)
                                  : Icon(Icons.cancel_sharp,
                                      color: Colors.redAccent[700])),
                          Text("Return",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16))
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: isDue == true
                                ? Icon(
                                    Icons.timer_off_rounded,
                                  )
                                : Icon(
                                    Icons.timer_off_rounded,
                                    color: Colors.yellowAccent,
                                  ),
                          ),
                          Text("Due",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16))
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time),
                          Text(books['EndDate'])
                        ],
                      )
                    ])),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.indigo[900],
                    border: Border.all(width: 1, color: Colors.indigo),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          focusColor: Colors.yellow,
                          hoverColor: Colors.yellowAccent,
                          highlightColor: Colors.blue,
                          color: editcolor,
                          onPressed: () {
                            showBookDetails(books, context);
                          },
                          icon: Icon(FontAwesomeIcons.book)),
                      IconButton(
                          focusColor: Colors.yellow,
                          hoverColor: Colors.yellowAccent,
                          highlightColor: Colors.blue,
                          color: editcolor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateIssueBook(
                                        bookKey: key,
                                        user: widget.user,
                                        admData: widget.admData,
                                      )),
                            );
                          },
                          icon: Icon(FontAwesomeIcons.edit)),
                      IconButton(
                          focusColor: Colors.yellow,
                          hoverColor: Colors.yellowAccent,
                          highlightColor: Colors.blue,
                          color: editcolor,
                          onPressed: () {
                            deleteBooks(context, books["BookName"], key);
                          },
                          icon: Icon(Icons.delete)),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.white70,
                          ),
                          Text(
                            " S ${books['StartDate']}\\E ${books['EndDate']} ",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ],
                  ),
                )
                // ExpansionPanelList(
                //   animationDuration: Duration(microseconds: 2000),
                //   children: [
                //     ExpansionPanel(
                //       headerBuilder: (context, isExpand) {
                //         return Text("");
                //       },
                //       body: ListTile(
                //         title: Text("Anilsahu"),
                //       ),
                //       isExpanded: _expand,
                //       canTapOnHeader: true,
                //     ),
                //   ],
                //   dividerColor: Colors.greenAccent,
                //   expansionCallback: (panelIndex, isExpanded) {
                //     _expand = !_expand;
                //     setState(() {});
                //   },
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var studentkey = widget.user.key;

    var _issuebookcollection = admCollection
        .doc(widget.admData.key)
        .collection("student")
        .doc(studentkey)
        .collection("borrow")
        .where("StudentKey", isEqualTo: studentkey);

    Stream<QuerySnapshot> __issuedbookStream = _issuebookcollection.snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: Text(widget.user.email),
        actions: [],
      ),
      drawer: Drawer(
        child: Material(
          color: Colors.indigo[900],
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              buildHeader(
                  name: widget.user.name,
                  email: widget.user.email,
                  profile: userUrl),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1,
                color: Colors.white,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text("Member Details",
                          style: TextStyle(
                              color: Colors.greenAccent, fontSize: 18)),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                    buildMenuItem(
                        key: "Name", value: widget.user.name, icon: Icons.add),
                    buildMenuItem(
                        key: "Member Id",
                        value: widget.user.student_id,
                        icon: Icons.card_membership),
                    buildMenuItem(
                        key: "Mobile No.",
                        value: widget.user.mobile_number,
                        icon: Icons.phone),
                    buildMenuItem(
                        key: "Email Id",
                        value: widget.user.email,
                        icon: Icons.email),
                    Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Books Activities",
                          style: TextStyle(
                              color: Colors.limeAccent, fontSize: 18)),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                    buildMenuItem(
                      key: "Total Issue",
                      value: widget.user.issuebook,
                      icon: Icons.arrow_circle_down,
                    ),
                    buildMenuItem(
                        key: "Total reuturn",
                        value: widget.user.returnbook,
                        icon: Icons.arrow_circle_up),
                    buildMenuItem(
                        key: "Charges",
                        value: widget.user.returnbook,
                        icon: Icons.money),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: // ),
          Center(
        child: StreamBuilder(
            stream: __issuedbookStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              // try{}catch(e){}
              if (snapshot.hasError) {
                return const Text("Something went rong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> stud =
                      document.data()! as Map<String, dynamic>;
                  var key = document.id;

                  if (stud.isNotEmpty) {
                    return issueBooks(books: stud, context: context, key: key);
                  }
                  if (snapshot.hasData == false) {
                    return const Center(child: Text("No data"));
                  }
                  return CircularProgressIndicator();
                }).toList(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "Add",
        backgroundColor: Colors.indigo[900],
        tooltip: "Add a Book",
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IssueBook(
                        stdData: widget.user,
                        adminData: widget.admData,
                      )));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
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
            title: Image.network(bookUrl),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                        "Issue/Submition Date : ${bookDetails['StartDate']} - ${bookDetails['EndDate']}"),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.indigo,
                  ),
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
                      //   _delete(ref);
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

  Widget buildHeader({
    required String name,
    required String email,
    required String profile,
  }) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10),
        //   padding: const EdgeInsets.symmetric(vertical: 00),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profile),
              radius: 40,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  email,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                )
              ],
            ),
            //  const Spacer(),
            //  const CircleAvatar(
            //    radius: 24,backgroundColor: Color.fromRGBO(30, 60, 168,1),
            //    child: Icon(Icons.add_comment_outlined,color: Colors.white,),
            //  )
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String key,
    required var value,
    required IconData icon,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        key,
        style: TextStyle(color: color),
      ),
      subtitle: Text("$value", style: TextStyle(color: Colors.white54)),
      hoverColor: hoverColor,
      onTap: () {},
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
                          .doc(widget.admData.key)
                          .collection("student")
                          .doc(widget.user.key)
                          .collection("borrow")
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

  returnBook(contex, book, startDate, submitionDate, bool isReturn, key) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: const [
                Icon(
                  Icons.warning,
                  color: Colors.yellowAccent,
                ),
                Text(
                  "Return book",
                  style: TextStyle(),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            content: Text(
                "If borrower have submit $book then press Return else press No"),
            actions: [
              ElevatedButton(
                  style: buttonstyle(),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "No",
                    style: textStyle(),
                  )),
              ElevatedButton(
                  style: buttonstyle(),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("Admin")
                        .doc(widget.admData.key)
                        .collection("student")
                        .doc(widget.user.key)
                        .update(({"Returnbook": (++widget.user.returnbook)}));
                    isReturn = true;
                    FirebaseFirestore.instance
                        .collection("Admin")
                        .doc(widget.admData.key)
                        .collection("student")
                        .doc(widget.user.key)
                        .collection("borrow")
                        .doc(key)
                        .update({"isReturn": isReturn}).whenComplete(
                      () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 3),
                        content: Text("$book have Return successFully"),
                      )),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text("Return", style: textStyle())),
            ],
          );
        });
  }

  issueLength(admkey, stdkey) {
    var totalIssueBook = 0;
    var bookL = admCollection
        .doc(admkey)
        .collection("student")
        .doc(stdkey)
        .collection("borrow")
        .where("StudentKey", isEqualTo: stdkey)
        .get()
        .then((value) {
      totalIssueBook = value.docs.length;
      print(totalIssueBook);
    });
    return totalIssueBook;
  }

  returnLength(admkey, stdkey) {
    var bookL = admCollection
        .doc(admkey)
        .collection("student")
        .doc(stdkey)
        .collection("borrow")
        .where("StudentKey", isEqualTo: stdkey);

    var returnedBooks = 0;
    bookL.where("isReturn", isEqualTo: true).get().then((value) {
      returnedBooks = value.docs.length;
    });
    return returnedBooks;
  }
}
