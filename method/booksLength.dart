import 'package:cloud_firestore/cloud_firestore.dart';

bookLength(admKey) async {
  var totalBooks;
  await FirebaseFirestore.instance
      .collection("Admin")
      .doc(admKey)
      .collection("book")
      .get()
      .then((value) {
    totalBooks = value.docs.length;
    ;
  });
  return totalBooks;
}
