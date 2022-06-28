import 'package:flutter/material.dart';

class DropDownMenuButton extends StatefulWidget {
  const DropDownMenuButton({Key? key}) : super(key: key);

  @override
  _DropDownMenuButtonState createState() => _DropDownMenuButtonState();
}

class _DropDownMenuButtonState extends State<DropDownMenuButton> {
  String dropdownValue = ' ';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      //  dropdownColor: Colors.pinkAccent,
      hint: const Text(
        "Please select ",
      ),
      value: dropdownValue,
      icon: const Icon(
        Icons.arrow_downward,
        color: Colors.white,
      ),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: const SizedBox(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>[
        ' ',
        'Detaile',
        'Edit',
        'Delete',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
              child: Text(
            value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                backgroundColor: Colors.pinkAccent),
          )),
        );
      }).toList(),
    );
  }
}
