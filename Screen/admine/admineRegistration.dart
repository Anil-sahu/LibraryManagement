// // ignore_for_file: avoid_unnecessary_containers, file_names

// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:library_management/method/variables/globalVariable.dart';
// import 'package:library_management/widget/textfieldColor.dart';

// var instituteName;
// var instituteCode;

// class RestrationAdmine extends StatefulWidget {
//   //AdminData admData;
//    const RestrationAdmine({Key? key}) : super(key: key);

//   @override
//   _RestrationAdmineState createState() => _RestrationAdmineState();
// }

// class _RestrationAdmineState extends State<RestrationAdmine> {
//   String? username;
//   var mobileNumber;
//   var email;
//   var password;
//   var conf_password;
//   var libraryName;
//   final formKey = GlobalKey<FormState>();
//   var _ref =FirebaseDatabase.instance.reference() ;
//   var fileUrl;
//   var imageNetwork;
//   var url;
//   var _image;
//   var ref;
//   var id;
//   final now = new DateTime.now();

//   final _auth = FirebaseAuth.instance;
//   // var db = FirebaseFirestore.instance.collection("user");
//   final fb = FirebaseDatabase.instance;
//   Future getImages(inputSource) async {
//     var _picker = ImagePicker();
//     var img = await _picker.pickImage(
//       source:
//           inputSource == "camera" ? ImageSource.camera : ImageSource.gallery,
//       maxWidth: 150,
//       maxHeight: 150,
//     );
//     setState(() {
//       _image = File(img!.path);
//     });
//   }

//   uploadImage(BuildContext context, index,admKey) async {
//     List<dynamic> files = [];
//     var storeImage = FirebaseStorage.instance
//         .ref()
//         .child("user")
//         .child("Admin")
//         .child(_image.path);
//     UploadTask uploadImages = storeImage.putFile(_image);
//     fileUrl = await (await uploadImages).ref.getDownloadURL();

//     url = fileUrl.toString();
//     files.add(url);
//     Map<String, dynamic> _admine = {
//       "name": username,
//       "Institute": instituteName,
//       "InstituteCode": instituteCode,
//       "Mobile": mobileNumber,
//       "email": email,
//       "password": password,
//       "profile": files[index],
    
//     };

//    _ref.child(admKey).set(_admine).then((value) {
//       // AdminData adminData = AdminData(
//       //   aname: _admine["name"],
//       //   institutename: _admine["institute"],
//       //   institutecode: _admine["instituteCode"],
//       //   contact: _admine["Mobile"],
//       //   instituteemail: _admine["email"],
//       //   institutepass: _admine["password"],
//       //   confpass: _admine["profile"],
//       //   key: 

//       // );
//       //      AddStudents(admData: adminData,);
//     });
//   }

//   // Future<void> _delete(String ref) async {
//   //   await storage.ref(ref).delete();
//   //   // Rebuild the UI
//   //   setState(() {});
//   // }

//   @override
//   initState() {
//     super.initState();
//   }

//   pickimages() async {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: Colors.white,
//             title: Text("Pick image from"),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         var camera = "camera";
//                         getImages(camera);
//                         Navigator.of(context).pop();
//                       },
//                       icon: Icon(
//                         Icons.camera_alt,
//                         size: 45,
//                         color: Colors.indigo[900],
//                       )),
//                   IconButton(
//                       onPressed: () {
//                         var camera = "gallery";
//                         getImages(camera);
//                         Navigator.of(context).pop();
//                       },
//                       icon: Icon(
//                         Icons.image,
//                         size: 45,
//                         color: Colors.indigo[900],
//                       )),
//                 ],
//               ),
//             ],
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: appbar(title),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: [
//               // SizedBox(height: 20,),
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.2,
//                 alignment: Alignment.center,
//                 color: Colors.indigo[900],
//                 width: double.maxFinite,
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.admin_panel_settings,
//                       size: 50,
//                       color: Colors.white,
//                     ),
//                     Text(
//                       "Admin",
//                       style: TextStyle(color: Colors.white, fontSize: 20),
//                     ),
//                   ],
//                 ),
//               ),

//               Form(
//                 key: formKey,
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * 0.8,
//                   // margin: EdgeInsets.only(top:10),
//                   child: SingleChildScrollView(
//                     // color: containercolor,
//                     padding: const EdgeInsets.only(
//                         left: 20, right: 20, bottom: 20, top: 0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(10),
//                           margin: EdgeInsets.all(10),
//                           child: _image != null
//                               ? Image.file(_image)
//                               : Stack(alignment: Alignment.center, children: [
//                                   Container(
//                                       padding: EdgeInsets.all(10),
//                                       alignment: Alignment.bottomCenter,
//                                       height: 100,
//                                       width: 100,
//                                       color: Colors.indigo[900],
//                                       child: Text(
//                                         "profile photo",
//                                         style:
//                                             TextStyle(color: Colors.white54),
//                                       )),
//                                   IconButton(
//                                     onPressed: () {
//                                       pickimages();
//                                     },
//                                     icon: Icon(
//                                       Icons.upload_sharp,
//                                       size: 40,
//                                       color: Colors.white24,
//                                     ),
//                                   ),
//                                 ]),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         TextFormField(
//                           //   controller: username,
//                           decoration: textfield(
//                               userlabel, userhint, usericon, username),
//                           onChanged: (value) {
//                             username = value;
//                           },
//                           validator: (value) {
//                             username = value;
//                             if (value!.isEmpty ||
//                                 !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
//                               return "Please enter correct name";
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           //    controller:instituteName,
//                           decoration: textfield(instituteNamelabel,
//                               instituteNamehint, schoolIcon, instituteName),
//                           onChanged: (value) {
//                             setState(() {
//                               instituteName = value;
//                             });
//                           },
//                           validator: (value) {
//                             setState(() {
//                               instituteName = value;
//                             });

//                             if (value!.isEmpty ||
//                                 !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
//                               return "Please enter correct name";
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           //   controller: instituteCode,
//                           decoration: textfield(instituteCodelabel,
//                               instituteCodehint, codeIcon, instituteCode),
//                           onChanged: (value) {
//                             setState(() {
//                               instituteCode = value;
//                             });
//                           },
//                           validator: (value) {
//                             setState(() {
//                               instituteCode = value;
//                             });

//                             if (value!.isEmpty ||
//                                 !RegExp(r'^[0-9]+$').hasMatch(value)) {
//                               return "Please enter correct name";
//                             } else {
//                               return null;
//                             }
//                           },
//                           keyboardType: TextInputType.number,
//                           //s  maxLength: 10,
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           //  controller: mobileNumber,
//                           decoration: textfield(mobilelabel, mobilehint,
//                               phonIcon, mobileNumber),
//                           onChanged: (value) {
//                             mobileNumber = value as int;
//                           },
//                           validator: (value) {
//                             setState(() {
//                               mobileNumber = value;
//                             });

//                             if (value!.isEmpty ||
//                                 !RegExp(r'^([0-9]).{10,}$')
//                                     .hasMatch(value)) {
//                               return "please Enter valid mobile number";
//                             } else {
//                               return null;
//                             }
//                           },
//                           keyboardType: TextInputType.phone,
//                         //  maxLength: 10,
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           //   controller: email,
//                           decoration: textfield(
//                               emaillabel, emailhint, emailicon, email),
//                           onChanged: (value) {
//                             email = value;
//                           },
//                           validator: (value) {
//                             email = value!;
//                             if (value.isEmpty ||
//                                 RegExp(r'^[\w-\.]+@([\w-]_\.)+[\w-]{2-4}')
//                                     .hasMatch(value)) {
//                               return "Please enter correct name";
//                             } else {
//                               return null;
//                             }
//                           },
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           //  controller: password,
//                           decoration: textfield(
//                               passlabel, passhint, passicon, password),
//                           onChanged: (value) {
//                             password = value;
//                           },
//                           validator: (value) {
//                             password = value!;

//                             if (value.isEmpty ||
//                                 !RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*~_-]).{8,}$')
//                                     .hasMatch(value)) {
//                               return "Password should be cantaine at least one uppercass, lowercase, digit, special symbol";
//                             } else {
//                               return null;
//                             }
//                           },

//                           obscureText: true,
//                           obscuringCharacter: "#",
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           // controller:conf_password,
//                           decoration: textfield(conpasslabel, conpasshint,
//                               passicon, conf_password),
//                           // onChanged: (value) {
//                           //   conf_password = value as TextEditingController;
//                           // },
//                           validator: (value) {
//                             conf_password = value!;

//                             if (conf_password == password) {
//                               return "Confirm Password should be matched";
//                             } else {
//                               return null;
//                             }
//                           },
//                           obscureText: true,
//                           obscuringCharacter: "#",
//                         ),
//                         SizedBox(
//                           height: 40,
//                         ),
//                         Container(
//                           width: 200,
//                           height: 50,
//                           decoration: buttondecoration(),
//                           child: ElevatedButton(
//                             style: buttonstyle(),
//                             onPressed: () async {
//                               int index = 0;
//                               if (formKey.currentState!.validate()) {
                                
//                                // uploadImage(context, index,id);
//                                 try {
//                                   await _auth
//                                       .createUserWithEmailAndPassword(
//                                     email: email,
//                                     password: password,
//                                   ).then((value){
//                                      id = _auth.currentUser!.uid;
                            
//                                     uploadImage(context, index,id);
//                                     print("--------------------------------------------------------");
//                                    print(id);
//                                   }).whenComplete((){
                                    
//                                      _ref.child(id).once().then((DataSnapshot value) {
//                                          Map admin = value.value;
       
//                                      print("--------------------------------------------------------");
//                                      print(admin["name"]);
//                                      print("--------------------------------------------------------");
//                                      print(admin["email"]);
//                                      print("--------------------------------------------------------");
//                                      print(admin["Mobile"]);
//                                      print("--------------------------------------------------------");
//                                      print(value.key);
//                                       });
                                      
                                    
                           
                                 
//                                   });
                                  
//                                   ScaffoldMessenger.of(context)
//                                       .showSnackBar(SnackBar(
//                                     content:
//                                         Text("Registration is Successfully"),
//                                     duration: Duration(seconds: 5),
//                                   ));
//                                   // _ref = FirebaseDatabase.instance
//                                   //     .reference()
//                                   //     .child("$instituteName")
//                                   //     .child("$instituteCode").push();
//                                   // Navigator.push(
//                                   //   context,
//                                   //   MaterialPageRoute(
//                                   //     builder: (context) => ManageRoute(admData: widget.admData,),
//                                   //   ),
//                                   // );
                            
//                                 } on FirebaseAuthException catch (e) {
//                                   print(e.message);
//                                   email = "";
//                                   password = "";
//                                   conf_password = "";
//                                   username = "";
//                                   instituteCode = "";
//                                   instituteName = "";
//                                 }
//                               }
//                             },
//                             child: Text(
//                               "Sign Up",
//                               style: TextStyle(
//                                   fontSize: 20, color: Colors.indigo[900]),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 25,
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             // Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //     builder: (context) => AdminLogin(admData: widget.admData,),
//                             //   ),
//                             // );
//                           },
//                           child: Text.rich(
//                             TextSpan(
//                                 text:
//                                     "If you have all ready registered then click -",
//                                 style: TextStyle(color: Colors.black87),
//                                 children: <InlineSpan>[
//                                   TextSpan(
//                                       text: "Here",
//                                       style: TextStyle(
//                                           decoration:
//                                               TextDecoration.underline,
//                                           color: Colors.indigo[900]))
//                                 ]),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
