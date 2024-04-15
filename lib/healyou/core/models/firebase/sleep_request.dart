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

  static Future<void> addSleep(Sleep data) async {
    String id = FirebaseHelper.sleepCollection.doc().id;
    await FirebaseHelper.sleepCollection.doc(id).set({
      "id": id,
      "user": FirebaseAuth.instance.currentUser!.uid,
      ...data.toJson()
    });
  }

  static Future<void> deleteSleep(String id) async {
    await FirebaseHelper.sleepCollection.doc(id).delete();
  }

  static Future<void> updateSleep(String id, Map<String, dynamic> data) async {
    await FirebaseHelper.sleepCollection.doc(id).update(data);
  }
}
