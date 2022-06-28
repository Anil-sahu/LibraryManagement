import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:library_management/color/Colors.dart';
import 'package:library_management/login_sevices/authentication.dart';
import 'package:library_management/method/variables/globalVariable.dart';

class AdminLoginService extends StatefulWidget {
  const AdminLoginService({Key? key}) : super(key: key);

  @override
  _AdminLoginServiceState createState() => _AdminLoginServiceState();
}

class _AdminLoginServiceState extends State<AdminLoginService> {
  final formKey = GlobalKey<FormState>();
  final DatabaseReference _ref = FirebaseDatabase.instance.reference();

  var adminName;
  var adminPassword;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("images/1.png"),
                    fit: BoxFit.fill,
                  )),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text("Admin Login",
                    style: TextStyle(
                      fontSize: 20,
                      color: afocusColor,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: const BoxDecoration(),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.red,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide:
                                BorderSide(color: afocusColor, width: 2)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: aenableColor,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: aerrorColor),
                          gapPadding: 0,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide:
                                BorderSide(color: afocusColor, width: 2)),
                        errorStyle: TextStyle(color: aerrorColor),
                        focusColor: Colors.blue[200],
                        prefixIcon: Icon(
                          Icons.person,
                          color: aenableColor,
                        ),
                        suffixIcon: loading == true
                            ? const CircularProgressIndicator(
                                color: Color(0xFFFFB268),
                              )
                            : Icon(
                                Icons.close,
                                color: aenableColor,
                              ),
                        labelText: "Username",
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        hintText: "Enter your username",
                        hintStyle: const TextStyle(color: Colors.grey)),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      adminName = value!;
                      if (value.isEmpty) {
                        return "Please Enter valid username";
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        adminName = value;
                      });
                    },
                    style: TextStyle(color: afocusColor),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      fillColor: Colors.red,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide(color: afocusColor, width: 2)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(color: aenableColor, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: aerrorColor),
                        gapPadding: 0,
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide(color: afocusColor, width: 2)),
                      errorStyle: TextStyle(color: errorColor),
                      focusColor: Colors.blue[200],
                      prefixIcon: Icon(
                        Icons.lock,
                        color: aenableColor,
                      ),
                      suffixIcon: loading == true
                          ? const CircularProgressIndicator(
                              color: Color(0xFFFFB268),
                            )
                          : Icon(
                              Icons.close,
                              color: aenableColor,
                            ),
                      labelText: "Password",
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      hintText: "Enter password",
                      hintStyle: const TextStyle(color: Colors.grey)),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    adminPassword = value!;
                    if (value.isEmpty) {
                      return "Please Enter valid password";
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      adminName = value;
                    });
                  },
                  style: TextStyle(color: afocusColor),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        primary: Colors.orange[100],
                        onPrimary: Colors.blue,
                        shadowColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                        alignment: Alignment.center,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          loading = true;

                          setState(() {
                            SignInUser user = SignInUser();
                            user.userSignIn(
                                context,
                                adminName.toString().trim(),
                                adminPassword.toString().trim());
                          });
                        } else {
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      child: loading == true
                          ? const CircularProgressIndicator(
                              color: Colors.orange,
                            )
                          : Text(
                              "LogIn",
                              style: TextStyle(
                                  color: Colors.orange[600], fontSize: 25),
                            )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
