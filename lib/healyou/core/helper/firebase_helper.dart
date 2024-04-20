import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  static var waterItemCollection =
      FirebaseFirestore.instance.collection('waterTargetItems');
  static var targetCollection =
      FirebaseFirestore.instance.collection('targets');
  static var userCollection = FirebaseFirestore.instance.collection('user');
  static String userId = FirebaseAuth.instance.currentUser!.uid;
}
