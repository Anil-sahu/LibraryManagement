// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:library_management/color/Colors.dart';

var textColor = Colors.white;
var buttoncolor = Colors.white;
var containercolor = Colors.indigo[900];
var tfColor = Colors.blue[100];
var outlineColor = Colors.white;
var labelColor = Colors.blue[900];
//var icons = Icons.person;

textfield(labeltext, hinttext, icons, value) {
  return InputDecoration(
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.indigoAccent, width: 2)),
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.indigo, width: 1)),
    filled: true,
    //focusColor: Colors.indigo[900],
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      borderSide: BorderSide(
        width: 2,
        color: errorColor,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      borderSide: BorderSide(
        width: 2,
        color: errorColor,
      ),
    ),
    prefixIcon: Icon(icons),
    suffixIcon: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          value.clear();
        }),
    prefixText: "  ",
    labelText: labeltext,
    labelStyle: TextStyle(color: labelColor),
    hintText: hinttext,
    hintStyle: const TextStyle(color: Colors.black54, fontSize: 16),
  );
}

buttondecoration() {
  return BoxDecoration(
      //color:buttoncolor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.indigo,
          offset: Offset(1.0, 2.0),
          blurRadius: 3,
          spreadRadius: 1,
        ),
      ]);
}

buttonstyle() {
  return ElevatedButton.styleFrom(
    elevation: 2,
    primary: Colors.indigo[900],
    onPrimary: Colors.blue,
    shadowColor: Colors.black,
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
  );
}

thButtonStyle() {
  return ElevatedButton.styleFrom(
    elevation: 2,
    primary: Colors.indigo[900],
    onPrimary: Colors.blue,
    shadowColor: Colors.black,
    side: const BorderSide(
      color: Colors.white,
      width: 1,
    ),
    alignment: Alignment.center,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  );
}

thbuttondecoration() {
  return BoxDecoration(
      //color:buttoncolor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Colors.indigo,
          offset: Offset(1.0, 2.0),
          blurRadius: 2,
          spreadRadius: 1,
        ),
      ]);
}

textStyle() {
  return const TextStyle(
    color: Colors.white,
    fontSize: 12,
  );
}
