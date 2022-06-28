// ignore_for_file: file_names

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_management/Screen/users/allBooks.dart';
import 'package:library_management/Screen/users/issuesBook.dart';
import 'package:library_management/Screen/users/studentPage.dart';
import 'package:library_management/color/Colors.dart';
import 'package:library_management/method/studentData.dart';

class userRout extends StatefulWidget {
  StudentData studentData;
   userRout({Key? key,required this.studentData}) : super(key: key);

  @override
  _userRoutState createState() => _userRoutState();
}

class _userRoutState extends State<userRout> {
  Color? iconcolor = focusColor;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPage(),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: enableColor,
        selectedIndex: index,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
         this.index = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.university),
            title: const Text('Books'),
            activeColor: iconcolor!,
            textAlign: TextAlign.center,
          ),
            BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.bookDead),
            title: const Text('Issue'),
            activeColor: iconcolor!,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.user),
            title: const Text('profile'),
            activeColor: iconcolor!,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  buildPage() {
    switch (index) {
      case 1:
        return IssuedBooks(user: widget.studentData);
        case 2:
        return DetailsPage(studentData:widget.studentData,);
              
      case 0:
      default:
        return AllBoooks();
    }
  }
}
