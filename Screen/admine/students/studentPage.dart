import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_management/Screen/admine/students/deletestudent.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/method/studentData.dart';
import 'package:library_management/method/variables/globalVariable.dart';
import 'package:line_icons/line_icons.dart';
import 'addstudent.dart';
import 'detailsScreen.dart';
import 'updatestudent.dart';

class StudentPage extends StatefulWidget {
  AdminData adminData;

  var searchController = "";
  StudentPage(
      {Key? key, required this.searchController, required this.adminData})
      : super(key: key);

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  var stud;
  var title = "Students ";

  var stdkey;
  @override
  initState() {
    super.initState();
  }

  Widget studentlist({required Map students, required BuildContext context}) {
    stdkey = students["studentskey"];
    var admkey = widget.adminData.key;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 145, width: 140, child: Image.network(userUrl)),
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(left: 20),
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width - 178,
                  child: ListView(
                    itemExtent: 40,
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: const Text("Name"),
                        subtitle: Text(students["name"]),
                      ),
                      ListTile(
                        title: const Text("mobile"),
                        subtitle: Text(students["mobile"]),
                      ),
                      ListTile(
                        title: const Text("Email"),
                        subtitle: Text(students["email"]),
                      ),
                    ],
                  ),
                ),
                SizedBox(
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
                  IconButton(
                      focusColor: Colors.yellow,
                      hoverColor: Colors.yellowAccent,
                      highlightColor: Colors.blue,
                      color: Colors.white,
                      onPressed: () {
                        StudentData user = StudentData(
                            name: students["name"],
                            email: students["email"],
                            mobile_number: students["mobile"],
                            password: students["password"],
                            student_id: students["studentId"],
                            issuebook: students["Issuebooks"],
                            returnbook: students["Returnbook"],
                            key: students["studentkey"]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                    user: user,
                                    admData: widget.adminData,
                                  )),
                        );
                      },
                      icon: const Icon(
                        FontAwesomeIcons.userAlt,
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
                              builder: (context) => UpdateStudent(
                                    studentKey: students["studentkey"],
                                    admindata: widget.adminData,
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
                        deleteStudent(context, students["name"], admkey,
                            students["studentkey"], loading);
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 18,
                      )),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.white54,
                      ),
                      Text(students["Date"],
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 16)),
                    ],
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
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> studentcollection = FirebaseFirestore.instance
        .collection("Admin")
        .doc(widget.adminData.key)
        .collection("student")
        .snapshots();
    setState(() {
      loading = false;
    });

    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: studentcollection,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> stud =
                      document.data()! as Map<String, dynamic>;
                  if (stud.isNotEmpty) {
                    if (stud['name']
                            .toLowerCase()
                            .contains(widget.searchController) ||
                        stud["studentId"]
                            .toLowerCase()
                            .contains(widget.searchController)) {
                      return studentlist(students: stud, context: context);
                    } else {
                      return const Text("");
                    }
                  }
                  return const Center(child: Text("No Mathes data"));
                }).toList(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        heroTag: const Text("AddStudent"),
        tooltip: "Add new User",
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddStudents(
                        admdata: widget.adminData,
                      )));
        },
        child: const Icon(Icons.person_add_alt),
      ),
    );
  }
}
