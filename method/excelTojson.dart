// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

class ExcelToJson {
  Future<String?> convert() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['xlsx', 'csv', 'xls']);
    if (file != null && file.files.isNotEmpty) {
    //  var read =  File(file.paths).readAsBytesSync();
      var bytes = File(file.files.first.path!).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      int i = 0;
      List<dynamic> keys = <dynamic>[];
      List<Map<String, dynamic>> json = <Map<String, dynamic>>[];
      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]?.rows ?? []) {
          try {
            if (i == 0) {
              keys = row;
              i++;
            } else {
              Map<String, dynamic> temp = <String, dynamic>{};
              int j = 0;
              String tk = '';
              for (var key in keys) {
                tk = key.value;
                temp[tk] = (row[j].runtimeType == String)
                    ? "\u201C" + row[j].value + "\u201D"
                    : row[j].value;
                j++;
              }
           var n=   json.add(temp);
          ;
          
            }
          } catch (ex) {}
        }
      }
      String fullJson = jsonEncode(json);
      print("________________________________-----------------------_____________________________");
print(fullJson[1].toString());
print(fullJson[ 0].toString());
      File(file.files.first.path!).delete();
      return fullJson;
    }
    return null;
  }
}