// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:library_management/Screen/admine/books/categories.dart';
import 'package:library_management/Screen/admine/notes.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/widget/textfieldColor.dart';
import 'package:line_icons/line_icons.dart';

var name = "Anil";
var email = "111anilsahu@gmail.com";
var rollNumber = "30410221028";
var mobileNu = "610356817";

class HomePage extends StatefulWidget {
  AdminData admData;
  HomePage({Key? key, required this.admData}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

var title = "HomePage";
Color? iconcolor = Colors.indigo[100];

var searchicon = Icons.search;

var ref = FirebaseDatabase.instance.reference();

var categories;
final adminCollection = FirebaseFirestore.instance.collection("Admin");

int totalBooks = 0;
int totalMembers = 0;
var searchController = "";

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    adminCollection
        .doc(widget.admData.key)
        .collection("book")
        .get()
        .then((value) {
      totalBooks = value.docs.length;
    });

    adminCollection
        .doc(widget.admData.key)
        .collection("student")
        .get()
        .then((value) {
      totalMembers = value.docs.length;
    });

    return Scaffold(
      body: mainBody(context, widget.admData, totalBooks, totalMembers),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: const Text("categories"),
        onPressed: () {
          newCategories(context);
        },
        label: const Text("Categories", style: TextStyle(color: Colors.white)),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.indigo[900],
      ),
    );
  }

  newCategories(BuildContext context) {
    String categorie = "...";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text("Add New Categoris"),
            content: TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter category name",
              ),
              onChanged: (value) {
                setState(() {
                  categorie = value;
                  //  print(widget.admData.key);
                });
              },
            ),
            actions: [
              SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                      style: buttonstyle(),
                      onPressed: () {
                        var ctg = {"category": categorie.toUpperCase()};
                        ref
                            .child(widget.admData.key)
                            .child("Categories")
                            .push()
                            .set(ctg)
                            .then((value) {
                          const CircularProgressIndicator();
                        }).whenComplete(() {
                          Navigator.of(context).pop();
                        });
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))),
            ],
          );
        });
  }
}

Widget mainBody(
    BuildContext context, AdminData adminData, totalBooks, totalMembers) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.8,
    child: SingleChildScrollView(
      child: Column(
        //  mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 100,
            color: Colors.indigo[300],
            padding: const EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: thButtonStyle(),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => UploadFileOption(
                      //             adminData: adminData,
                      //           )),
                      // );
                    },
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            LineIcons.bookOfTheDead,
                            color: Colors.white,
                          ),
                          Text(
                            "Books",
                            style: textStyle(),
                          ),
                          Text(
                            "$totalBooks",
                            style: const TextStyle(
                                color: Colors.yellowAccent, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: thButtonStyle(),
                      onPressed: () async {},
                      child: SizedBox(
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              LineIcons.user,
                              color: Colors.white,
                            ),
                            Text(
                              "Members",
                              style: textStyle(),
                            ),
                            Text(
                              "$totalMembers",
                              style: const TextStyle(
                                  color: Colors.yellowAccent, fontSize: 20),
                            )
                          ],
                        ),
                      )),
                  ElevatedButton(
                    style: thButtonStyle(),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NotesPage(admData: adminData)));
                    },
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            LineIcons.editAlt,
                            color: Colors.white,
                          ),
                          Text(
                            "Notes",
                            style: textStyle(),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
          const Divider(),
          StreamBuilder(
              stream: ref.child(adminData.key).child("Categories").onValue,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.snapshot.value != null) {
                    Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                    List<dynamic> list = map.values.toList();
                    // print(list.length);
                    return GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: list.length,
                      padding: const EdgeInsets.all(2.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: Colors.white,
                              onPrimary: Colors.blue,
                              onSurface: Colors.indigo[900],
                              side: const BorderSide(
                                color: Colors.indigo,
                                width: 1,
                              ),
                              alignment: Alignment.center,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookCategories(
                                          categories: list[index]["category"],
                                          searchController: searchController,
                                          adminData: adminData)));
                            },
                            onLongPress: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  LineIcons.book,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                Text("${list[index]["category"]}",
                                    style: const TextStyle(
                                        color: Colors.black54, fontSize: 16)),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(2.0),
                        );
                      },
                    );
                  } else {
                    return const Center(
                        child: Text(
                      "There's no data",
                      style: TextStyle(fontSize: 20.0, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ));
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ],
      ),
    ),
  );
}
