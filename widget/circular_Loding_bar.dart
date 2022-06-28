
// ignore_for_file: file_names

import 'package:flutter/material.dart';

progressBar(BuildContext context){
  return showDialog(
    barrierColor: Color(0x77BDBDBD),
    context:context,builder: (context){
      return AlertDialog(
        backgroundColor:Colors.white,
        title: Column(
          children: [
            CircularProgressIndicator(backgroundColor: Colors.blue[400],color:const Color(0xFFE3F2FD),),
            const Text("Please wait...",style: TextStyle(color:Color(0xFFDBDBDB)),),
         
          ],
        ),
        );

    }
  );
}