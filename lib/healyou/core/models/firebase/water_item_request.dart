import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healyou/healyou/core/helper/firebase_helper.dart';
import 'package:healyou/healyou/core/models/waterTargetItem/water_target_item.dart';

class WaterItemRequest {
  static Stream<List<WaterTargetItem>> getAll() =>
      FirebaseHelper.waterItemCollection.snapshots().map((event) =>
          event.docs.map((e) => WaterTargetItem.fromJson(e.data())).toList());
  static Future<void> updateNotify(String id, bool notifyValue) async {
    await FirebaseHelper.waterItemCollection
        .doc(id)
        .update({"isNotify": notifyValue});
  }

  static Future<void> addWaterReminder(Map<String, dynamic> data) async {
    String id = await FirebaseHelper.waterItemCollection.doc().id;
    data["id"] = id;
    await FirebaseHelper.waterItemCollection.doc(id).set(data);
  }

  static Future<void> deleteWaterReminder(String id) async {
    await FirebaseHelper.waterItemCollection.doc(id).delete();
  }
}
