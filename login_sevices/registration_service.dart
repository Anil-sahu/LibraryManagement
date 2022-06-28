// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class SignUpUser {
//   var id;
//   final _auth = FirebaseAuth.instance;
//   var ref = FirebaseDatabase.instance.reference();
//   userSignUp(BuildContext context, Map users) async {
//     try {
//       _auth
//           .createUserWithEmailAndPassword(email: users["name"], password: users["email"])
//           .then((value) {
      
//         id = _auth.currentUser!.uid;
//       }).whenComplete(() {
//         ref.child(id).set(users).then((value) {
        
//         }).whenComplete((){
//   // Map admin = value.value;
//           // AdminData admData = new AdminData(
//           //     aname: admin["name"],
//           //     institutename: admin["Institute"],
//           //     institutecode: admin["InstituteCode"],
//           //     contact: 5667778888,
//           //     instituteemail: admin["email"],
//           //     profile: admin["profile"],
//           //     key: id);
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => ManageRoute(
//           //       admData: admData,
//           //     ),
//           //   ),
//           // );
//         });
//       });
//     } on FirebaseAuthException catch (e) {
//       print(e.message);
//       signInError(context, e.code);
//     }
//   }

//   signInError(BuildContext context, error) {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Error"),
//             content: Text(error),
//             actions: [
//               ElevatedButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: Text("ok"))
//             ],
//           );
//         });
//     //  return error;
//   }
// }
