// ignore_for_file: file_names
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:library_management/method/studentData.dart';
import 'package:library_management/method/variables/globalVariable.dart';
import 'package:library_management/widget/appbar.dart';

class DetailsPage extends StatefulWidget {
  StudentData studentData;
  DetailsPage({Key? key, required this.studentData}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  Map stud = {};
  var title = "Students ";
  var ref;
  var reference;
  final DatabaseReference _reference = FirebaseDatabase.instance.reference();

  @override
  initState() {
    super.initState();
    reference = _reference.child("Student").child(widget.studentData.key);
    ref = reference.orderByChild("name");
  }

  Widget studentlist({required Map students, required BuildContext context}) {
    return Container(
      height: 182,
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      color: Colors.white,
      // child: Card(
      //   elevation: 5,
      //   shadowColor: Colors.grey,
      //   child: Column(
      //     children: [
      //
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           GestureDetector(
      //             onTap: () {
      //           //    StudentData user = StudentData(students["name"], students["email"], students["mobile"],students["password"],students["studentId"],students["BookIssue"],students["profile"],stud["key"]);

      //             //  IssueBook(studentKey: stud["key"]);
      //             },
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: const [
      //                 Icon(
      //                   Icons.person,
      //                   color: Colors.indigo,
      //                 ),
      //                 Text(
      //                   "Profile",
      //                   style: TextStyle(color: Colors.indigo),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           //   SizedBox(width: 10,),
      //           GestureDetector(
      //             onTap: () {
      //             //  Navigator.push(context, MaterialPageRoute(builder:(context)=>IssueBook()));
      //               // Navigator.push(
      //               //   context,
      //               //   MaterialPageRoute(
      //               //       builder: (context) =>
      //               //           UpdateStudent(studentKey: stud["key"],admindata: widget.adminData,)),
      //               // );
      //             },
      //             child: Row(
      //               children: const [
      //                 Icon(
      //                   Icons.edit,
      //                   color: Colors.blueAccent,
      //                 ),
      //                 Text(
      //                   "Edit",
      //                   style: TextStyle(color: Colors.blueAccent),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           GestureDetector(
      //             onTap: () {
      //            //   deleteStudent(students, context);
      //             },
      //             child: Row(
      //               children: [
      //                 Icon(
      //                   Icons.delete,
      //                   color: Colors.red[800],
      //                 ),
      //                 Text(
      //                   "delet",
      //                   style: TextStyle(color: Colors.red[800]),
      //                 ),
      //               ],
      //             ),
      //           )
      //         ],
      //       )
      //     ],
      //   ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: appbar(title, context),
        // drawer: drawer(),
        body: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Container(
                  //  height: MediaQuery.of(context).size.height * 0.8,
                  //   child: FirebaseAnimatedList(
                  //     query: ref,
                  //     itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  //         Animation<double> animation, int index) {
                  //       stud = snapshot.value;
                  //       stud["key"] = snapshot.key;
                  //       return studentlist(students: stud, context: context);
                  //     },
                  //   ),
                  // ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: CircleAvatar(
                            foregroundColor: Colors.red,
                            radius: 80,
                            backgroundImage: NetworkImage(userUrl),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              ListTile(
                                title: Text(
                                  "Name:-${widget.studentData.name}",
                                  style: style(),
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              ListTile(
                                title: Text(
                                  "Id :- ${widget.studentData.student_id}",
                                  style: style(),
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              ListTile(
                                title: Text(
                                  "Mobile No. :-${widget.studentData.mobile_number}",
                                  style: style(),
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              ListTile(
                                title: Text(
                                  "Email Id :- ${widget.studentData.email}",
                                  style: style(),
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo[900],
          tooltip: "Add new User",
          onPressed: () {},
          child: const Icon(Icons.person_add_alt),
        ),
      ),
    );
  }

  // deleteStudent(Map students1, BuildContext context) async {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Row(children: [
  //             const Icon(
  //               Icons.cancel_outlined,
  //               color: Colors.red,
  //             ),
  //             Text("Delete  ${students1['name']} "),
  //           ]),
  //           content: const Text("Are you sure you want to delete?"),
  //           actions: [
  //             Container(
  //               child: ElevatedButton(
  //                   style: buttonstyle(),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: const Text(
  //                     "Cancel",
  //                     style: TextStyle(color: Colors.indigoAccent),
  //                   )),
  //             ),
  //             Container(
  //               child: ElevatedButton(
  //                   style: buttonstyle(),
  //                   onPressed: () {
  //                  //   _delete(ref);
  //                     reference
  //                         .child(students1["key"])
  //                         .remove()
  //                         .whenComplete(() => Navigator.of(context).pop());

  //                   },
  //                   child: const Text(
  //                     "Delete",
  //                     style: TextStyle(color: Colors.redAccent),
  //                   )),
  //             ),
  //           ],
  //         );
  //       });
  // }

  // Future<void> _delete(String ref) async {
  //   await storage.ref(ref).delete();
  //   // Rebuild the UI
  //   setState(() {});
  // }

}
