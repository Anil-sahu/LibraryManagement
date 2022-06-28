// ignore_for_file: file_names

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'admindata.dart';

class UploadFileOption extends StatefulWidget {
  AdminData adminData;
  UploadFileOption({Key? key, required this.adminData}) : super(key: key);

  @override
  _UploadFileOptionState createState() => _UploadFileOptionState();
}

class _UploadFileOptionState extends State<UploadFileOption> {
  var myExcelFile;
  var url;
  var _ref;
  int index = 0;
  UploadTask? task;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child(widget.adminData.key)
        .child("dataFile")
        .child("studetnData");
  }

  @override
  Widget build(BuildContext context) {
    final fileName =
        myExcelFile != null ? basename(myExcelFile) : "No file selected";
    return Container(
      color: Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                selectFile();
              },
              child: const Icon(Icons.upload_file)),
          Text(
            fileName,
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                //int index = 0;
                // UploadFiles(context);
              },
              child: const Icon(Icons.upload_file)),
        ],
      ),
    );
  }

  Future selectFile() async {
    final pickFile = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (pickFile == null) return;
    var path = pickFile.files.single.path;
    String filepath = path.toString();
    setState(() {
      myExcelFile = filepath;
    });

    var bytes = File(filepath).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    var j = 0;
    for (var table in excel.tables.keys) {
      //  print(table); //sheet Name
      Map<int, List<String>> map = <int, List<String>>{};
      int col = excel.tables[table]!.maxCols;
      int row = excel.tables[table]!.maxRows;
      for (var i = 0; i <= row; i++) {
        //   map[++j] = row.cast<String>();

        //    print("${row[i]} \n");

      }
    }
  }

  // ignore: non_constant_identifier_names
  // UploadFiles(context) async {
  // List<dynamic> files = [];
  // if (myExcelFile == null) return;
  // final filename = basename(myExcelFile!.path);
  // final destination = "files/$filename";
  // task = FirebaseApi.uploadFile(destination, myExcelFile);
  // if (task == null) return;
  //   final snapshot = await task!.whenComplete(() {});
  //  var downloadUrl = await snapshot.ref.getDownloadURL();

  // print("---------------------------------------------");

  // ignore: avoid_print
  // print("download url $downloadUrl");
  // files.add(downloadUrl);
//Map _data = {
  //"Student data": files[index],
  // };
  // var file = downloadUrl;
  // var myfile = file.split('?');
  // var fileUri = Uri.parse(myfile[0]);
  //  print("---------------------------------------------");
  //print(myfile[0]);
  // var byte = File.fromUri(fileUri).readAsBytesSync();
  //var bytes = File(myfile[0]).readAsBytesSync();
  //var decoder = SpreadsheetDecoder.decodeBytes(byte);
  // var table = decoder.tables['sheet1'];
  // var values = table!.rows[0];
  // print(values);
  // var excel = Excel.decodeBytes(byte);
  // for (var table in excel.tables.keys) {
  //   print(table);
  //   print(excel.tables[table]!.maxCols);
  //   print(excel.tables[table]!.maxRows);
  //   for (var row in excel.tables[table]!.rows) {
  //     print(row);
  //   }
  // }
  // _ref.push().set(_data).then((value) {}).whenComplete(() {
  //  Navigator.of(context).pop();
  //  });

  // _ref.set(files[index]).then((value) {
  //     Navigator.of(context).pop();
  //     print("upload successFull");
}

// UploadFiles(BuildContext context, index)async{
//    List<dynamic> files = [];
// var uploadExcelFile=  FirebaseStorage.instance.ref().child("path").child(myExcelFile!.path);
//    UploadTask uploadFile =  uploadExcelFile.putData(myExcelFile);
//    var fileUrl = await (await uploadFile).ref.getDownloadURL();
//    url = fileUrl.toString();
//    files.add(url);
// _ref.set(files[index]).then((value) {
//     Navigator.of(context).pop();
//     print("upload successFull");
//   });

// }
//}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File myExcelFile) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(myExcelFile);
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putData(data);
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
