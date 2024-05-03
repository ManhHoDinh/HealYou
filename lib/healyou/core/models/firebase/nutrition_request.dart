import 'package:firebase_auth/firebase_auth.dart';
import 'package:healyou/healyou/core/helper/firebase_helper.dart';
import 'package:healyou/healyou/core/models/nutrition/nutrition.dart';

class NutritionRequest {
  static Stream<List<Nutrition>> getAll(String userId) => FirebaseHelper.nutritionCollection
      .where("user", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots()
      .map((event) =>
          event.docs.map((e) => Nutrition.fromJson(e.data())).toList());
  static Future<void> updateNotify(String id, bool notifyValue) async {
    await FirebaseHelper.sleepCollection
        .doc(id)
        .update({"isNotify": notifyValue});
  }

  static Future<void> add(Nutrition data) async {
    var doc = FirebaseHelper.sleepCollection.doc();
    await FirebaseHelper.sleepCollection.doc(doc.id).set({
      ...data.toJson(),
      "id": doc.id,
      "user": FirebaseAuth.instance.currentUser!.uid,
    });
  }

  static Future<void> delete(String id) async {
    await FirebaseHelper.sleepCollection.doc(id).delete();
  }

  static Future<void> update(String id, Map<String, dynamic> data) async {
    await FirebaseHelper.sleepCollection.doc(id).update(data);
  }
}
