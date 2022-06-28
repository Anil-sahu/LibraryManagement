// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_management/login_sevices/selction_screen.dart';
import 'package:library_management/method/admindata.dart';
import 'package:library_management/method/variables/globalVariable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class NavigationDrawerWidget extends StatefulWidget {
  AdminData adminData;
  NavigationDrawerWidget({Key? key, required this.adminData}) : super(key: key);

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Material(
          //  color:Color.fromRGBO(50, 75, 205, 1),
          color: Colors.indigo[900],
          child: ListView(
            //  padding: EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            children: <Widget>[
              buildHeader(
                name: widget.adminData.aname,
                email: widget.adminData.instituteemail,
                profile: userUrl,
                //  onClicked:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminDetail(adminData: widget.adminData)))
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                color: Colors.white70,
              ),
              buildMenuItem(
                text: "Profile",
                icon: Icons.people,
              ),
              const SizedBox(
                height: 16,
              ),
              buildMenuItem(
                text: "Home",
                icon: Icons.home,
              ),
              const SizedBox(
                height: 16,
              ),
              buildMenuItem(text: "support", icon: Icons.help_center),
              const SizedBox(
                height: 16,
              ),
              buildMenuItem(
                text: "privacy/Security",
                icon: Icons.security_outlined,
              ),
              const SizedBox(
                height: 24,
              ),
              const Divider(
                color: Colors.white70,
              ),
              const SizedBox(
                height: 24,
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                ),
                title: const Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.white),
                ),
                hoverColor: Colors.white70,
                onTap: () async {
                  final SharedPreferences sp =
                      await SharedPreferences.getInstance();
                  sp.remove('email');

                  await FirebaseAuth.instance.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectWhoAreYou()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
  }) {
    final color = Colors.white;
    const hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: () {},
    );
  }

  Widget buildHeader({
    required String name,
    required String email,
    required String profile,
  }) {
    return InkWell(
      onTap: () {},
      child: Container(
        //   padding: const EdgeInsets.symmetric(vertical: 00),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profile),
              radius: 40,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  email,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                )
              ],
            ),
            //  const Spacer(),
            //  const CircleAvatar(
            //    radius: 24,backgroundColor: Color.fromRGBO(30, 60, 168,1),
            //    child: Icon(Icons.add_comment_outlined,color: Colors.white,),
            //  )
          ],
        ),
      ),
    );
  }
}
