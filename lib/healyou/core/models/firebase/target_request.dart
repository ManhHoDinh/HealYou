import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healyou/healyou/core/helper/firebase_helper.dart';
import 'package:healyou/healyou/core/models/target/target.dart';
import 'package:intl/intl.dart';

class TargetRequest {
  static Stream<List<Target>> getAll() =>
      FirebaseHelper.waterItemCollection.snapshots().map(
          (event) => event.docs.map((e) => Target.fromJson(e.data())).toList());
  static Future<void> updateNotify(String id, bool notifyValue) async {
    await FirebaseHelper.waterItemCollection
        .doc(id)
        .update({"isNotify": notifyValue});
  }

  static Future<void> autoAddRunTarget(Map<String, dynamic> data) async {
    String runTargetId = await FirebaseHelper.targetCollection.doc().id;
    String kcalTargetId = await FirebaseHelper.targetCollection.doc().id;
    String kmTargetId = await FirebaseHelper.targetCollection.doc().id;
    String timeTargetId = await FirebaseHelper.targetCollection.doc().id;
    DateTime time = DateTime.now();
    // QuerySnapshot listDocs =  await FirebaseHelper.targetCollection.doc().get();
    // for(QueryDocumentSnapshot doc in listDocs.d)
  }

  static Future<void> deleteWaterReminder(String id) async {
    await FirebaseHelper.waterItemCollection.doc(id).delete();
  }
}
