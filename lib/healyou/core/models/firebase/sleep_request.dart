import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healyou/healyou/core/helper/firebase_helper.dart';
import 'package:healyou/healyou/core/models/sleep/sleep.dart';

class SleepRequest {
  static Stream<List<Sleep>> getAll() => FirebaseHelper.sleepCollection
      .where("user", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots()
      .map((event) => event.docs.map((e) => Sleep.fromJson(e.data())).toList());
  static Future<void> updateNotify(String id, bool notifyValue) async {
    await FirebaseHelper.sleepCollection
        .doc(id)
        .update({"isNotify": notifyValue});
  }

  static Stream<List<Sleep>> getByDate(DateTime start, DateTime end) =>
      FirebaseHelper.sleepCollection
          .where("user", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where("startTime", isGreaterThanOrEqualTo: Timestamp.fromDate(start))
          .where('startTime', isLessThanOrEqualTo: Timestamp.fromDate(end))
          .orderBy("startTime")
          .snapshots()
          .map((event) =>
              event.docs.map((e) => Sleep.fromJson(e.data())).toList());
  static Future<void> addSleep(Sleep data) async {
    var doc = FirebaseHelper.sleepCollection.doc();
    await FirebaseHelper.sleepCollection.doc(doc.id).set({
      ...data.toJson(),
      "id": doc.id,
      "user": FirebaseAuth.instance.currentUser!.uid,
    });
  }

  static Future<void> deleteSleep(String id) async {
    await FirebaseHelper.sleepCollection.doc(id).delete();
  }

  static Future<void> updateSleep(String id, Map<String, dynamic> data) async {
    await FirebaseHelper.sleepCollection.doc(id).update(data);
  }

  static Future<void> addSleepTime(
      String id, DateTime start, DateTime end) async {
    await FirebaseHelper.sleepCollection.doc(id).update({
      "sleepTime": FieldValue.arrayUnion(
          [Timestamp.fromDate(start), Timestamp.fromDate(end)])
    });
  }
}
