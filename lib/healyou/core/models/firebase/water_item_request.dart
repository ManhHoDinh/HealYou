import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healyou/healyou/core/helper/firebase_helper.dart';
import 'package:healyou/healyou/core/models/waterTargetItem/water_target_item.dart';

class WaterItemRequest {
  static Future<List<WaterTargetItem>> getAll(String userId) async {
    var listDoc = await FirebaseHelper.waterItemCollection.get();
    if (listDoc.size > 0) {
      return await FirebaseHelper.waterItemCollection
          .where("userId", isEqualTo: userId)
          .orderBy("time", descending: true)
          .snapshots()
          .map((event) => event.docs
              .map((e) => WaterTargetItem.fromJson(e.data()))
              .toList())
          .first;
    } else {
      return [];
    }
  }

  static Future<void> updateNotify(String id, bool notifyValue) async {
    await FirebaseHelper.waterItemCollection
        .doc(id)
        .update({"isNotify": notifyValue});
  }

  static Future<void> addWaterReminder(Map<String, dynamic> data) async {
    String id = FirebaseHelper.waterItemCollection.doc().id;
    data["id"] = id;
    await FirebaseHelper.waterItemCollection.doc(id).set(data);
  }

  static Future<void> deleteWaterReminder(String id) async {
    await FirebaseHelper.waterItemCollection.doc(id).delete();
  }

  static Future<void> removeReminder() async {
    var listDoc = await FirebaseHelper.waterItemCollection.get();
    print(listDoc);
    for (var doc in listDoc.docs) {
      WaterTargetItem item = WaterTargetItem.fromJson(doc.data());
      if (item.time!.isBefore(DateTime.now()) ||
          item.time!.isAtSameMomentAs(DateTime.now())) {
        FirebaseHelper.waterItemCollection.doc(item.id).delete();
      }
    }
  }
}
