// import 'package:flutter/material.dart';
// import 'package:library_management/Screen/admine/students/detailsScreen.dart';
// import 'package:library_management/Screen/admine/students/updatestudent.dart';
// import 'package:library_management/method/studentData.dart';

// Widget studentlist({required Map students, required BuildContext context}) {
//   var stud;
//   return Container(
//     height: 200,
//     margin: const EdgeInsets.only(bottom: 10, top: 10),
//     child: Card(
//       elevation: 5,
//       shadowColor: Colors.grey,
//       shape: const RoundedRectangleBorder(
//         side: BorderSide(color: Colors.indigo, width: 1),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               SizedBox(
//                 height: 145,
//                 width: 145,
//                 child: students["profile"] != null
//                     ? Image.network(students["profile"])
//                     : const Icon(Icons.image_outlined),
//               ),
//               Column(
//                 children: [
//                   Container(
//                       alignment: Alignment.centerRight,
//                       child: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.more_vert_outlined,
//                           size: 16,
//                         ),
//                       )),
//                   Container(
//                     padding: const EdgeInsets.only(left: 20),
//                     color: Colors.white,
//                     width: MediaQuery.of(context).size.width - 158,
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             const Icon(
//                               Icons.person,
//                               color: Colors.indigo,
//                               size: 16,
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width - 213,
//                               child: Text(
//                                 students["name"],
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                     color: Colors.indigo[900], fontSize: 16),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             const Icon(
//                               Icons.phone,
//                               color: Colors.blue,
//                               size: 16,
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width - 213,
//                               child: Text(
//                                 students["mobile"],
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                     color: Colors.indigo[900], fontSize: 16),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             const Icon(
//                               Icons.email,
//                               color: Colors.deepOrange,
//                               size: 16,
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width - 213,
//                               child: Text(
//                                 students["email"],
//                                 overflow: TextOverflow.ellipsis,
//                                 softWrap: true,
//                                 maxLines: 1,
//                                 style: TextStyle(
//                                     color: Colors.indigo[900], fontSize: 16),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 6,
//           ),
//           Container(
//             height: 40,
//             decoration: BoxDecoration(
//               color: Colors.indigo[900],
//               border: Border.all(width: 1, color: Colors.indigo),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     StudentData user = StudentData(
//                         name: students["name"],
//                         email: students["email"],
//                         mobile_number: students["mobile"],
//                         password: students["password"],
//                         student_id: students["studentId"],
//                         userImage: students["profile"],
//                         key: stud["key"]);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => DetailScreen(
//                                 user: user,
//                                 admData: adminData,
//                               )),
//                     );
//                     //  IssueBook(studentKey: stud["key"]);
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Icon(
//                         Icons.person,
//                         color: Colors.white,
//                       ),
//                       Text(
//                         "Profile",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 //   SizedBox(width: 10,),
//                 GestureDetector(
//                   onTap: () {
//                     //  Navigator.push(context, MaterialPageRoute(builder:(context)=>IssueBook()));
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => UpdateStudent(
//                                 studentKey: stud["key"],
//                                 admindata: widget.adminData,
//                               )),
//                     );
//                   },
//                   child: Row(
//                     children: const [
//                       Icon(
//                         Icons.edit,
//                         color: Colors.white,
//                       ),
//                       Text(
//                         "Edit",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     //  deleteStudent(students, context);
//                   },
//                   child: Row(
//                     children: const [
//                       Icon(
//                         Icons.delete,
//                         color: Colors.white,
//                       ),
//                       Text(
//                         "delet",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }
