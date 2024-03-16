import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healyou/healyou/core/models/user/user.dart';

import '../../../../firebase_options.dart';

class FireBaseDataBase {
  static CollectionReference? referenceRooms;
  // static Stream<List<UserModel>> readRooms() => FirebaseFirestore.instance
  //     .collection(UserModel.CollectionName)
  //     .snapshots()
  //     .map((snapshot) =>
  //         snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());
  // static initializeDB() async {
  //   await Firebase.initializeApp(
  //       options: DefaultFirebaseOptions.currentPlatform);
  //   referenceRooms = await FirebaseFirestore.instance.collection('Rooms');
  // }
   static initializeDB() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

   static Stream<List<UserModel>> readUsers() =>
      FirebaseFirestore.instance.collection('Users').snapshots().map((event) =>
          event.docs.map((e) => UserModel.fromJson(e.data())).toList());
}