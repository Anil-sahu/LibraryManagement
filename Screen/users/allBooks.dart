// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AllBoooks extends StatefulWidget {
  const AllBoooks({ Key? key }) : super(key: key);

  @override
  _AllBoooksState createState() => _AllBoooksState();
}

class _AllBoooksState extends State<AllBoooks> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Books cann't fetch"),),
    );
  }
}