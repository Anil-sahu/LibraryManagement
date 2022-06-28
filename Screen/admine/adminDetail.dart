import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:library_management/login_sevices/selction_screen.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/widget/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDetail extends StatefulWidget {
  AdminData adminData;
  AdminDetail({Key? key, required this.adminData}) : super(key: key);

  @override
  _AdminDetailState createState() => _AdminDetailState();
}

class _AdminDetailState extends State<AdminDetail> {
  FirebaseStorage storage = FirebaseStorage.instance;
  var admKey;
  var title = "Admin Detail";
  var ref;
  var reference;
  final DatabaseReference _reference = FirebaseDatabase.instance.reference();
  @override
  initState() {
    super.initState();
    reference = _reference.child(widget.adminData.key);
    ref = reference.orderByChild("name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title, context),
      // drawer: drawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 1,
              alignment: Alignment.center,
              color: Colors.white,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.indigo[900],
                backgroundImage: NetworkImage(widget.adminData.profile),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Name",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black87)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(widget.adminData.aname,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black45))
                            ]),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit_outlined))
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Library Name",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black87)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(widget.adminData.aname,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black45))
                            ]),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit_outlined))
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Library id/Code",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black87)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('${widget.adminData.institutecode}',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black45))
                            ]),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit_outlined))
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Contact Number",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black87)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('${widget.adminData.contact}',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black45))
                            ]),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit_outlined))
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Email Id",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black87)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(widget.adminData.instituteemail,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black45))
                            ]),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit_outlined))
                      ],
                    ),
                  ),
                  const Divider(),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: Colors.indigo[900]),
                    onPressed: () async {
                      final SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      sp.remove('email');

                      await FirebaseAuth.instance.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectWhoAreYou()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      color: Colors.indigo[900],
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        "Sign Out",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      // child:Icon(Icons.logout_outlined)
                    ),
                  )
                ],
              ),
            ),
          ],
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
  //             ElevatedButton(
  //                 style: buttonstyle(),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text(
  //                   "Cancel",
  //                   style: TextStyle(color: Colors.indigoAccent),
  //                 )),
  //             Container(
  //               child: ElevatedButton(
  //                   style: buttonstyle(),
  //                   onPressed: () {
  //                     //   _delete(ref);
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
