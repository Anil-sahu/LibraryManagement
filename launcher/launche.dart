import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:flutter_email_sender/flutter_email_sender.dart';

class CreateLibrary extends StatefulWidget {
  const CreateLibrary({Key? key}) : super(key: key);

  @override
  CreateLibraryState createState() => CreateLibraryState();
}

class CreateLibraryState extends State<CreateLibrary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigo[900], title: const Text("Contact Us")),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("For Creating Your Library Please contact us"),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                        onPrimary: Colors.white,
                        onSurface: Colors.blue,
                        padding: const EdgeInsets.all(20),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => EmailLaunche()),
                        // );
                        // _launchEmail();
                        send();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.email_outlined,
                            size: 30,
                            color: Colors.red,
                          ),
                          Text(
                            "  Email",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "OR",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                        onPrimary: Colors.white,
                        onSurface: Colors.blue,
                        padding: const EdgeInsets.all(20),
                      ),
                      onPressed: () async {
                        const number = '7610356817';
                        await FlutterPhoneDirectCaller.callNumber(number);
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.phone,
                            size: 30,
                            color: Colors.blue,
                          ),
                          Text(
                            "  Phone",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ))
                ],
              )
            ]),
      ),
    );
  }

  // void _launchEmail() async {
  //   List<String> to = ["111anilsahu@gmail.com"];
  //   String subject = "Create My Library";
  //   String body =
  //       "Library Details \nLibrary name: \n LibrariyId Or code: \nEmail:\Phone Number:\n Profile Image:";

  //   Email email = Email(to: to, subject: subject, body: body);
  //   EmailLauncher.launch(email).then((value) {
  //     // success
  //     print(value);
  //   }).catchError((error) {
  //     // has error
  //     print(error);
  //   });
  // }

  Future<void> send() async {
    final Email email = Email(
      body:
          'Write here your Library Details \nLibrary name: \n LibrariyId Or code: \nEmail:\Phone Number:\n Profile Image:',
      subject: 'For Creating Library',
      recipients: ['111anilsahu@gmail.com'],
      cc: ['cc@example.com'],
      bcc: ['bcc@example.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }
}
