// ignore_for_file: file_names

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_management/Screen/MainPage/search_user.dart';
import 'package:library_management/Screen/admine/adminDetail.dart';
import 'package:library_management/Screen/admine/books/bookPage.dart';
import 'package:library_management/Screen/admine/students/studentPage.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/method/variables/globalVariable.dart';
import 'package:library_management/widget/NavigationDrawerr.dart';
import 'HomePage.dart';

class ManageRoute extends StatefulWidget {
  AdminData admData;
  ManageRoute({Key? key, required this.admData}) : super(key: key);

  @override
  _ManageRouteState createState() => _ManageRouteState();
}

class _ManageRouteState extends State<ManageRoute> {
  var searchController = "";
  Color? iconcolor = Colors.white;
  int index = 0;
  var title = ["Home Page", "Students page", "Books Page"];
  var appbarTitle = "My Library";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitle),
        backgroundColor: Colors.indigo[900],
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AdminDetail(adminData: widget.admData)
                        // AdminDetail(adminData: widget.admData)

                        ));
                print(widget.admData.aname);
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      drawer: NavigationDrawerWidget(adminData: widget.admData),
      body: buildPage(),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.indigo[900],
        selectedIndex: index,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          this.index = index;
          appbarTitle = title[index];
        }),
        items: [
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.university),
            title: const Text('Home'),
            activeColor: iconcolor!,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.bookReader),
            title: const Text('Student'),
            activeColor: iconcolor!,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.book),
            title: const Text('Books'),
            activeColor: iconcolor!,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchUser(admData: widget.admData)));
          },
          child: const Icon(Icons.search, color: Colors.white),
          backgroundColor: Colors.indigo[900]),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }

  buildPage() {
    switch (index) {
      case 1:
        loading = false;
        return StudentPage(
          searchController: searchController,
          adminData: widget.admData,
        );

      case 2:
        //   loading = false;
        //   return SearchUser(admData: widget.admData);
        // case 3:
        return BookPage(
          SearchController: searchController,
          adminData: widget.admData,
        );
      case 0:
      default:
        loading = false;
        return HomePage(
          admData: widget.admData,
        );
    }
  }
}
