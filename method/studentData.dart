// ignore_for_file: file_names

import 'package:flutter/material.dart';

class StudentData {
  var name = "";
  var mobile_number = "";
  var student_id = "";
  var email = "";
  var password = "";
  var key;

  var issuebook;
  var returnbook;

  StudentData(
      {required this.name,
      required this.email,
      required this.mobile_number,
      required this.password,
      required this.student_id,
      required this.key,
      required this.issuebook,
      required this.returnbook});
}

style() {
  return const TextStyle(
    color: Colors.indigo,
    fontSize: 16,
    fontFamily: 'Cascadia code',
  );
}
