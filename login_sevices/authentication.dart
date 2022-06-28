import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:library_management/Screen/MainPage/manageRoute.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/method/variables/globalVariable.dart';
import 'package:library_management/widget/circular_Loding_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInUser {
  var admine;
  var id;
  final _auth = FirebaseAuth.instance;
  //final adminecollection = FirebaseFirestore.instance.collection("collectionPath");
  final DatabaseReference _ref = FirebaseDatabase.instance.reference();
  userSignIn(BuildContext context, username, password) async {
    try {
      if (loading == true) progressBar(context);
      await _auth
          .signInWithEmailAndPassword(email: username, password: password)
          .then((value) {
        id = _auth.currentUser!.uid;
        print(
            "------------------------UserId_______--------------------------");
        print(id);
      }).whenComplete(() {
        _ref.child(id).onValue.listen((value) {
          admine = value.snapshot.value;
          AdminData adminData = AdminData(
              aname: admine["name"],
              institutename: admine["Institute"],
              institutecode: admine["InstituteCode"],
              contact: admine["Mobile"],
              instituteemail: admine["email"],
              profile: admine["profile"],
              key: id);

          //---------------------callinng set method for set shared preferences--------------------------------
          set();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ManageRoute(
                admData: adminData,
              ),
            ),
          );
        });
        loading = false;
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      signInError(context, e.code);
    }
  }

  signInError(BuildContext context, error) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(error),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("ok"))
            ],
          );
        });
    //  return error;
  }

  void set() async {
    final SharedPreferences sharepref = await SharedPreferences.getInstance();
    sharepref.setString('email', admine["email"]);
    sharepref.setString('name', admine["name"]);
    sharepref.setString('profile', admine["profile"]);
    sharepref.setString('libraryName', admine["Institute"]);
    sharepref.setString('librarycode', admine["InstituteCode"]);
    sharepref.setString('contact', admine["Mobile"]);
    sharepref.setString('key', id);
  }
}
