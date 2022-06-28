import 'package:flutter/material.dart';

Widget drawer(Map user) {
  return Container(
    color: Colors.indigoAccent,
    child: Drawer(
      elevation: 10,
      child: Row(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo[900],
            ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(user["profile"]),
              ),
              
              accountName: Text(user["name"]),
              accountEmail: Text(user["email"]))
        ],
      ),
    ),
  );
}
