import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/widget/textfieldColor.dart';

class NotesPage extends StatefulWidget {
  AdminData admData;
  NotesPage({
    Key? key,
    required this.admData,
  }) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    var noteCollection = FirebaseFirestore.instance
        .collection("Admin")
        .doc(widget.admData.key)
        .collection("Note");

    Stream<QuerySnapshot> noteStream = FirebaseFirestore.instance
        .collection("Admin")
        .doc(widget.admData.key)
        .collection("Note")
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: const Text("Notes"),
      ),
      body: Center(
        child: StreamBuilder(
            stream: noteStream,
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
                    Map<String, dynamic> note =
                        document.data()! as Map<String, dynamic>;
                    var id = document.id;

                    return Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(width: 2, color: Colors.indigo),
                        ),
                        padding: const EdgeInsets.only(
                            top: 14, left: 14, right: 14, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note['Note'],
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    focusColor: Colors.red,
                                    highlightColor: Colors.yellow,
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  IconButton(
                                    focusColor: Colors.yellow,
                                    highlightColor: Colors.red,
                                    onPressed: () {
                                      noteCollection.doc(id).delete();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                      ),
                                      Text(
                                        note['Date'],
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ],
                                  )
                                ]),
                          ],
                        ));
                  }).toList(),
                );
              }
              return const Text("No data");
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        onPressed: () {
          newNoteDailog(context, noteCollection);
        },
        child: const Icon(
          FontAwesomeIcons.solidEdit,
          color: Colors.white,
        ),
      ),
    );
  }

  newNoteDailog(BuildContext context, noteCollection) {
    String notes = "";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text("Add New Notes"),
            content: TextFormField(
              maxLines: 5,
              maxLength: 150,
              decoration: const InputDecoration(
                hintText: "Enter here your note ",
              ),
              onChanged: (value) {
                setState(() {
                  notes = value;
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
                        var ctg = {
                          "Note": notes,
                          "Date": DateTime.now().toString()
                        };
                        noteCollection.add(ctg).then((value) {
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
