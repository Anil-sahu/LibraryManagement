// // ignore_for_file: file_names

// import 'package:flutter/material.dart';

// import 'package:library_management/method/admindata.dart';
// import 'package:library_management/widget/textfieldColor.dart';



// // ignore: must_be_immutable
// class MainPage extends StatelessWidget {
//   AdminData admData;
//    MainPage({Key? key,required this.admData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       body:
//           Center(
//             child: Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [

//                   Container(
//                  //   height: 240,
//                     width: double.maxFinite,
//                     decoration: const BoxDecoration(
//                     //  color: Colors.indigo[900],
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                        // Image.asset("images/a.png"),
//                         Image.asset(
//                           "images/library (3).png",
//                         width: 165,
//                          height: 165, 
//                         ),
//                         Text("Library Management",
//                             style: TextStyle(
//                                 color: Colors.indigo,
//                                 fontSize: 30,
//                                 fontFamily: "Verdana")),
//                         SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 60,
//                   ),
//                   Container(
//                     width: 200,
//                     height: 60,
//                     decoration: buttondecoration(),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (context) => RestrationAdmine(admData: admData,),
//                         //   ),
//                         // );
//                       },
//                       style: buttonstyle(),
//                       child: Text(
//                         "Admin",
//                         style: TextStyle(fontSize: 20, color: Colors.indigo),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 40),
//                   Container(
//                     width: 200,
//                     height: 60,
//                     //color: Colors.blue,
//                     decoration: buttondecoration(),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => TeacherLogin()),
//                         );
//                       },
//                       style: buttonstyle(),
//                       child: Text(
//                         "Teacher",
//                         style: TextStyle(fontSize: 20, color: Colors.indigo),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Container(
//                     width: 200,
//                     height: 60,
//                     // color: Colors.blue,
//                     decoration: buttondecoration(),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (context) => StudentLogin(),
//                         //   ),
//                         // );
//                       },
//                       style: buttonstyle(),
//                       child: Text(
//                         "Students",
//                         style: TextStyle(fontSize: 20, color: Colors.indigo),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
     
//     );
//   }
// }
