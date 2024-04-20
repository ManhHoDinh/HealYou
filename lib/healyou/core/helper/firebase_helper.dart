import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  static var waterItemCollection =
      FirebaseFirestore.instance.collection('waterTargetItems');
  static var targetCollection =
      FirebaseFirestore.instance.collection('targets');
  static var sleepCollection = FirebaseFirestore.instance.collection('sleeps');
}
