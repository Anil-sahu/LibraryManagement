import 'package:flutter/material.dart';
import 'package:library_management/launcher/launche.dart';

import 'admin_login_services.dart';
import 'user_login_service.dart';

class SelectWhoAreYou extends StatefulWidget {
  const SelectWhoAreYou({Key? key}) : super(key: key);

  @override
  _SelectWhoAreYouState createState() => _SelectWhoAreYouState();
}

class _SelectWhoAreYouState extends State<SelectWhoAreYou> {
  String dropdownValue = '--select--';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            // color: backGroundColor,
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      padding: const EdgeInsets.only(top: 10, left: 45),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("images/5.png"),
                        fit: BoxFit.fill,
                      )),
                      child: const Text(
                        "My Library",
                        style: TextStyle(
                            color: Color(0xFFC8F0F8),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                //   SizedBox(height: 40,),
                const Text("Select who are You ?",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF3898A0),
                    )),
                Container(
                  // height: MediaQuery.of(context).size.height*0.6,

                  // color: Colors.blueAccent,
                  // margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.only(left: 20, right: 20),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButton<String>(
                          dropdownColor: Colors.pinkAccent,
                          hint: const Text(
                            "Please select ",
                          ),
                          value: dropdownValue,
                          icon: const Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                          ),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: const SizedBox(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>[
                            '--select--',
                            'Admine',
                            'Other',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    backgroundColor: Colors.pinkAccent),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 2,
                                primary: Colors.blue[100],
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
                                selctionCondition(context, dropdownValue);
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    color: Colors.indigo[900], fontSize: 30),
                              )),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateLibrary()));
                          },
                          child: const Text(
                            "Click here to create your library",
                            style: TextStyle(
                                color: Colors.indigo,
                                decoration: TextDecoration.underline,
                                fontSize: 15),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*---------------------invalid selection alert---------------------*/
  selectionAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blue[100],
            title: Row(
              children: const [
                Icon(
                  Icons.warning,
                  color: Colors.orangeAccent,
                  size: 20,
                ),
                Text(
                  "  Sorry!",
                  style: TextStyle(fontSize: 20, color: Colors.indigo),
                ),
              ],
            ),
            content: const Text(
                "Please select that, Who are..?\n From admin, teacher or Student"),
            actions: [
              Container(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        primary: Colors.indigoAccent,
                        onPrimary: Colors.blue,
                        shadowColor: Colors.blue,
                        side: const BorderSide(
                          color: Colors.indigoAccent,
                          width: 3,
                        ),
                        alignment: Alignment.center,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "Ok",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))),
            ],
          );
        });
  }

  /*--------------------selectioin Condition-------------------*/

  selctionCondition(BuildContext context, dropdownValues) {
    switch (dropdownValues) {
      case "Admine":
        // ignore: avoid_print
        print("Admine");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AdminLoginService()));
        break;
      case "Student":
        // ignore: avoid_print
        print("student");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserLoginService()));
        break;
      case "--select--":
        selectionAlert(context);
    }
  }
}
