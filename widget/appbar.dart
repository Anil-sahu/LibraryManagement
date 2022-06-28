import 'package:flutter/material.dart';

 appbar(title,BuildContext context){
  return AppBar(
    
    backgroundColor: Colors.indigo[900],
    title: Text(title,),
    actions: [
      IconButton(onPressed: (){
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminDetail(adminData: adminData,)));
      },icon:Icon(Icons.person)),
    ],
  );
}