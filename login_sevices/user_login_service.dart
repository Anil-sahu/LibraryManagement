import 'package:flutter/material.dart';
import 'package:library_management/color/Colors.dart';
import 'package:library_management/login_sevices/UserAuthentication.dart';
import 'package:library_management/method/variables/globalVariable.dart';

class UserLoginService extends StatefulWidget {
  const UserLoginService({Key? key}) : super(key: key);

  @override
  _UserLoginServiceState createState() => _UserLoginServiceState();
}

class _UserLoginServiceState extends State<UserLoginService> {
  final formKey = GlobalKey<FormState>();
  String userName = "";
  String userPassword = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("images/2.png"),
                      fit: BoxFit.fill,
                    )),
                  ),
                  const Text("User Login",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3898A0),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    child: TextFormField(
                      //   controller: userName,
                      decoration: InputDecoration(
                          fillColor: Colors.red,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide:
                                  BorderSide(color: focusColor, width: 2)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: enableColor,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: errorColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide:
                                  BorderSide(color: focusColor, width: 2)),
                          errorStyle: TextStyle(color: errorColor),
                          focusColor: Colors.blue[200],
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color(0xFF58B8C8),
                          ),
                          suffixIcon: loading == true
                              ? const CircularProgressIndicator(
                                  color: Color(0xFF58B8C8),
                                )
                              : const Icon(
                                  Icons.close,
                                  color: Color(0xFF58B8C8),
                                ),
                          labelText: "Username",
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          hintText: "Enter your username",
                          hintStyle: const TextStyle(color: Colors.grey)),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        userName = value!;
                        if (value.isEmpty) {
                          return "Please Enter valid username";
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          userName = value;
                        });
                      },
                      style: TextStyle(color: focusColor),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
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
                                  BorderSide(color: focusColor, width: 2)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: enableColor,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2, color: errorColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide:
                                  BorderSide(color: focusColor, width: 2)),
                          errorStyle: TextStyle(color: errorColor),
                          focusColor: Colors.blue[200],
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color(0xFF58B8C8),
                          ),
                          suffixIcon: loading == true
                              ? const CircularProgressIndicator(
                                  color: Color(0xFF58B8C8),
                                )
                              : const Icon(
                                  Icons.close,
                                  color: Color(0xFF58B8C8),
                                ),
                          labelText: "Password",
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          hintText: "Enter password",
                          hintStyle: const TextStyle(color: Colors.grey)),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        userPassword = value!;
                        if (value.isEmpty) {
                          return "Please Enter valid password";
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          userName = value;
                        });
                      },
                      style: TextStyle(color: focusColor),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          primary: Colors.teal[100],
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
                            setState(() {
                              loading = true;
                              UserSignIn user = UserSignIn();
                              user.userSignIn(
                                  context,
                                  userName.toString().trim(),
                                  userPassword.toString().trim());
                            });
                          } else {
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                        child: loading == true
                            ? const CircularProgressIndicator(
                                color: Color(0xFF58B8C8),
                              )
                            : Text(
                                "LogIn",
                                style:
                                    TextStyle(color: buttxtColor, fontSize: 25),
                              )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
