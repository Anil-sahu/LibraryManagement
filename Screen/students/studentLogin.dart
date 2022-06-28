// import 'package:flutter/material.dart';
// import 'package:library_management/Screen/MainPage/HomePage.dart';
// import 'package:library_management/Screen/admine/admineRegistration.dart';
// import 'package:library_management/widget/textfieldColor.dart';

// class StudentLogin extends StatefulWidget {
//   const StudentLogin({Key? key}) : super(key: key);

//   @override
//   _StudentLoginState createState() => _StudentLoginState();
// }

// class _StudentLoginState extends State<StudentLogin> {
// String email = "";
//     String password = "";
//     var emaillabel= " email/phone";
//     var emailhint = "email id/phone number";
//     var emailicons = Icons.email_outlined;
//     var passlabel = "Password";var passhint="Enter password";var passicons = Icons.lock;
//     var title = "Teacher Login";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       body: SingleChildScrollView(
        
//       child:Column(
//         children: [
//           Container(
//             height: 120,
//             alignment: Alignment.center,
//             width: double.maxFinite,
//             color: Colors.indigo[900],
//             child: Text("Student Login",style:TextStyle(color: Colors.white,fontSize: 30)),
//           ),
//          // SizedBox(height: 20,),
//           Padding(padding:EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
           
//                    Container(
// padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//                 color: Colors.indigo[900],
//               ),
//               child: Icon(
//                 Icons.person,
//                 size: 60,
//                 color: Colors.white,
//               ),
//             ),
//                   SizedBox(height: 20,),
//                   TextField(
//                     decoration: textfield(emaillabel, emailhint, emailicons,email),
//                     onChanged: (value) {
//                       email = value;
//                     },
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   TextField(
//                     decoration: textfield(passlabel, passhint, passicons,password),
//                     onChanged: (value) {
//                       password = value;
//                     },
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Container(
//                     width: 150,
//                     height: 50,
//                     decoration: buttondecoration(),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => HomePage(),
//                             ),
//                           );
//                       },
//                       style: buttonstyle(),
//                       child: Text(
//                         "Login",
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 25,),
//                   TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => RestrationAdmine()));
//                       },
                      
//                        child: Text.rich(
//                   TextSpan(
//                      text:" ",
//                      style: TextStyle(color: Colors.black54),
//                      children: <InlineSpan>[
//                        TextSpan(
//                          text: "Forget password",style: TextStyle(decoration: TextDecoration.underline,color: Colors.indigo[900])
//                        )
//                      ]
//                       ),
//                       ),),
//                 ],
//               ),),
//         ],
//       ),
      
//         ),
      
//     );
//   }
// }
