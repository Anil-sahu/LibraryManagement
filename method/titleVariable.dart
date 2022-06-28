 // Container(
                    //           //   //  color: Colors.black,
                    //           //   child: DropdownButton<String>(
                    //           //     dropdownColor: Colors.pinkAccent,
                    //           //     hint: const Text(
                    //           //       "Please select ",
                    //           //     ),
                    //           //     value: branch,
                    //           //     icon: const Icon(
                    //           //       Icons.arrow_downward,
                    //           //       color: Colors.grey,
                    //           //     ),
                    //           //     iconSize: 24,
                    //           //     elevation: 16,
                    //           //     style:
                    //           //         const TextStyle(color: Colors.deepPurple),
                    //           //     underline: const SizedBox(),
                    //           //     onChanged: (String? newValue) {
                    //           //       setState(() {
                    //           //         branch = newValue!;
                    //           //       });
                    //           //     },
                    //           //     items: <String>[
                    //           //       '--select--',
                    //           //       'CSE',
                    //           //       'ME',
                    //           //       'CE',
                    //           //       'ET&T'
                    //           //       'EE',
                    //           //       'BA',
                    //           //       'B.Ed',
                    //           //       'MBBS',
                    //           //       'B.com',
                    //           //       'M.com',
                    //           //     ].map<DropdownMenuItem<String>>(
                    //           //         (String value) {
                    //           //       return DropdownMenuItem<String>(
                    //           //         value: value,
                    //           //         child: Container(
                    //           //             child: Text(
                    //           //           value,
                    //           //           style: TextStyle(
                    //           //             color: Colors.indigo[900],
                    //           //             fontSize: 20,
                    //           //             //  backgroundColor: Colors.pinkAccent
                    //           //           ),
                    //           //         )),
                    //           //       );
                    //           //     }).toList(),
                    //           //   ),
                    //           // ),














                        // Center(
          //   child: StreamBuilder(
          //       stream: studentcollection,
          //       builder: (BuildContext context,
          //           AsyncSnapshot<QuerySnapshot> snapshot) {
          //         if (snapshot.hasError) {
          //           return const Text("Something went wrong");
          //         }
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return const CircularProgressIndicator();
          //         }

          //         return ListView(
          //           children:
          //               snapshot.data!.docs.map((DocumentSnapshot document) {
          //             Map<String, dynamic> stud =
          //                 document.data()! as Map<String, dynamic>;
          //             if (stud.isNotEmpty) {
          //               if (stud['name']
          //                       .toLowerCase()
          //                       .contains(searchController) ||
          //                   stud["studentId"]
          //                       .toLowerCase()
          //                       .contains(searchController)) {
          //                 return studentlist(students: stud, context: context);
          //               } else {
          //                 return Text("");
          //               }
          //             }
          //             return const Center(child: Text("No Mathes data"));
          //           }).toList(),
          //         );
          //         // return const CircularProgressIndicator();;
          //       }),
          // ),
          // Center(
          //   child: StreamBuilder(
          //       stream: bookcollection,
          //       builder: (BuildContext context,
          //           AsyncSnapshot<QuerySnapshot> snapshot) {
          //         if (snapshot.hasError) {
          //           return const Text("Something went wrong");
          //         }
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return const CircularProgressIndicator();
          //         }
          //         if (snapshot.hasData) {
          //           return ListView(
          //             children:
          //                 snapshot.data!.docs.map((DocumentSnapshot document) {
          //               Map<String, dynamic> bookdata =
          //                   document.data()! as Map<String, dynamic>;
          //               if (bookdata["BookName"]
          //                       .toLowerCase()
          //                       .contains(searchController) ||
          //                   bookdata["BookAccount"]
          //                       .toLowerCase()
          //                       .contains(searchController) ||
          //                   bookdata["BookAuthor"]
          //                       .toLowerCase()
          //                       .contains(searchController)) {
          //                 return booklist(books: bookdata, context: context);
          //               } else {
          //                 return const CircularProgressIndicator();
          //               }
          //             }).toList(),
          //           );
          //         }
          //         return Text("No data");
          //       }),
          // ),
