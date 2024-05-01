import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healyou/healyou/core/helper/firebase_helper.dart';
import 'package:healyou/healyou/core/models/target/target.dart';

class TargetRequest {
  static Stream<List<Target>> getAll() =>
      FirebaseHelper.waterItemCollection.snapshots().map(
          (event) => event.docs.map((e) => Target.fromJson(e.data())).toList());
  static Future<void> updateNotify(String id, bool notifyValue) async {
    await FirebaseHelper.waterItemCollection
        .doc(id)
        .update({"isNotify": notifyValue});
  }

  static Future<bool> checkTargetExist() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseHelper.targetCollection.get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        Timestamp timestamp = documentSnapshot.get('time');

        DateTime documentTime = DateTime.fromMillisecondsSinceEpoch(
            timestamp.millisecondsSinceEpoch);
        DateTime currentTime = DateTime.now();
        if (documentTime.year == currentTime.year &&
            documentTime.month == currentTime.month &&
            documentTime.day == currentTime.day) {
          return true;
        }
      }
      return false;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<void> autoAddRunTarget() async {
    String runTargetId = await FirebaseHelper.targetCollection.doc().id;
    String kcalTargetId = await FirebaseHelper.targetCollection.doc().id;
    String kmTargetId = await FirebaseHelper.targetCollection.doc().id;
    String timeTargetId = await FirebaseHelper.targetCollection.doc().id;
    bool isExist = await TargetRequest.checkTargetExist();
    if (!isExist) {
      Target runTarget = Target(
          id: runTargetId,
          time: DateTime.now(),
          type: TargetType.step,
          target: 4000);
      FirebaseHelper.targetCollection.doc(runTargetId).set(runTarget.toJson());
      Target kcalTarget = Target(
          id: kcalTargetId,
          time: DateTime.now(),
          type: TargetType.kcal,
          target: 400);
      FirebaseHelper.targetCollection
          .doc(kcalTargetId)
          .set(kcalTarget.toJson());
      Target kmTarget = Target(
          id: kmTargetId,
          time: DateTime.now(),
          type: TargetType.distance,
          target: 4);
      FirebaseHelper.targetCollection.doc(kmTargetId).set(kmTarget.toJson());
      Target timeTarget = Target(
          id: timeTargetId,
          time: DateTime.now(),
          type: TargetType.time,
          target: 40);
      FirebaseHelper.targetCollection
          .doc(timeTargetId)
          .set(timeTarget.toJson());
    }
  }

  static Stream<Target?> getTarget(TargetType targetType) {
    // Create a StreamController to manage the stream of Target objects
    StreamController<Target?> streamController = StreamController<Target?>();

    // Listen for updates on the target collection
    FirebaseHelper.targetCollection.snapshots().listen((querySnapshot) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        Timestamp timestamp = documentSnapshot.get('time');
        String type = documentSnapshot.get("type");

        DateTime documentTime = DateTime.fromMillisecondsSinceEpoch(
            timestamp.millisecondsSinceEpoch);
        DateTime currentTime = DateTime.now();
        if (documentTime.year == currentTime.year &&
            documentTime.month == currentTime.month &&
            documentTime.day == currentTime.day &&
            targetType == TargetType.values.byName(type)) {
          // Emit the Target object to the stream
          streamController.add(Target.fromJson(documentSnapshot.data()));
        }
      }
      // No need to close the stream after emitting all items
      // as it's a continuous stream of updates
    });

    // Return the stream from the StreamController
    return streamController.stream;
  }

  static Future<void> updateTarget(String id, int target) async {
    await FirebaseHelper.targetCollection.doc(id).update({"target": target});
  }
}
