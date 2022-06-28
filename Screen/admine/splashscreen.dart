// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:library_management/Screen/MainPage/manageRoute.dart';
import 'package:library_management/login_sevices/selction_screen.dart';
import 'package:library_management/method/admindata.dart';

import 'package:shared_preferences/shared_preferences.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  late AdminData admData;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var librname, emailId, librcode, librcontact, librprof, libid, aname;
  @override
  void initState() {
    super.initState();
    share().whenComplete(() async {
      Timer(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => emailId != null && libid != null
                ? ManageRoute(
                    admData: admData,
                  )
                : const SelectWhoAreYou()));
      });
    });
  }

  Future<void> share() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    var name = pref.getString('name');
    var libname = pref.getString('libraryName');
    var libcode = pref.getString('librarycode');
    var libprof = pref.getString('profile');
    var contact = pref.getString('contact');
    var key = pref.getString('key');
    setState(() {
      aname = name;
      librname = libname;
      emailId = email;
      librcode = libcode;
      librprof = libprof;
      librcontact = contact;
      libid = key;
    });
    admData = AdminData(
        aname: aname,
        institutename: librname,
        institutecode: librcode,
        contact: contact,
        instituteemail: emailId,
        profile: librprof,
        key: libid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Positioned(
                  top: 0,
                  child: Image.asset(
                    "images/library (3).png",
                    width: 150,
                    height: 150,
                  ),
                ),
                const Text(
                  "My Library ",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF753737),
                    // fontFamily: "Satisfy",
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
//  Future <void> getUsername() async{
//     final FirebaseAuth auth=FirebaseAuth.instance;
//    User? user = await auth.currentUser;
//     uid = user!.uid;
//    //final email = uid.email;
//    print(uid);

  // }
}
