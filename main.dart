import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screen/admine/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Library management',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const splashscreen(),
            debugShowCheckedModeBanner: false,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
