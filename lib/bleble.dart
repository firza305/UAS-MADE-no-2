// // Membuat data
// void createData(String title, String description) {
//   DatabaseReference ref = database.ref().child('data');
//   ref.push().set({
//     'title': title,
//     'description': description,
//   });
// }

// // Membaca data
// void readData() {
//   DatabaseReference databaseref = database.ref().child('data');
//   databaseref.once().then((DataSnapshot snapshot) {
//         Map<dynamic, dynamic> values =
//             snapshot.toString() as Map<dynamic, dynamic>;
//         values.forEach((key, values) {
//           if (kDebugMode) {
//             print('Title: ${values['title']}');
//           }
//           if (kDebugMode) {
//             print('Description: ${values['description']}');
//           }
//           if (kDebugMode) {
//             print('');
//           }
//         });
//       } as FutureOr Function(DatabaseEvent value));
// }

// // Memperbarui data
// void updateData(String key, String newTitle, String newDescription) {
//   DatabaseReference ref = database.ref().child('data').child(key);
//   ref.update({
//     'title': newTitle,
//     'description': newDescription,
//   });
// }