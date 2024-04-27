import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healyou/healyou/core/helper/AuthFunctions.dart';
import 'package:healyou/healyou/core/helper/firebase_helper.dart';
import 'package:healyou/healyou/core/models/firebase/user_request.dart';
import 'package:healyou/healyou/core/models/target/target.dart';
import 'package:healyou/healyou/core/models/user/user.dart';
import 'package:intl/intl.dart';

class TargetRequest {
  static Stream<List<Target>> getAll() =>
      FirebaseHelper.targetCollection.snapshots().map(
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
    UserModel? user = await UserRequest.getById(FirebaseHelper.userId).first;
    print(user);
    if (user!.age != 0 &&
        user!.height != 0 &&
        user.weight != 0 &&
        user.gender != "") {
      print('đúng');
      String runTargetId = await FirebaseHelper.targetCollection.doc().id;
      String kcalTargetId = await FirebaseHelper.targetCollection.doc().id;
      String kmTargetId = await FirebaseHelper.targetCollection.doc().id;
      String timeTargetId = await FirebaseHelper.targetCollection.doc().id;
      String waterTargetId = await FirebaseHelper.targetCollection.doc().id;
      double caloTarget =
          calculateCalo(user!.weight, user.height, user.gender, user.age)
              .round()
              .toDouble();
      double stepTarget = (caloTarget / 0.05).round().toDouble();
      double distanceTarget = (stepTarget / 1000) * 1.5;
      double time = 0;
      double water = user!.weight * 35;
      if (user.gender == 'male') {
        time = (distanceTarget / 5);
      } else
        time = distanceTarget / 4.5;
      bool isExist = await TargetRequest.checkTargetExist();

      if (!isExist) {
        Target runTarget = Target(
            userId: FirebaseHelper.userId,
            id: runTargetId,
            time: DateTime.now(),
            type: TargetType.step,
            target: stepTarget);
        FirebaseHelper.targetCollection
            .doc(runTargetId)
            .set(runTarget.toJson());
        Target kcalTarget = Target(
            userId: FirebaseHelper.userId,
            id: kcalTargetId,
            time: DateTime.now(),
            type: TargetType.kcal,
            target: caloTarget);
        FirebaseHelper.targetCollection
            .doc(kcalTargetId)
            .set(kcalTarget.toJson());
        Target kmTarget = Target(
            userId: FirebaseHelper.userId,
            id: kmTargetId,
            time: DateTime.now(),
            type: TargetType.distance,
            target: distanceTarget);
        FirebaseHelper.targetCollection.doc(kmTargetId).set(kmTarget.toJson());
        Target timeTarget = Target(
            userId: FirebaseHelper.userId,
            id: timeTargetId,
            time: DateTime.now(),
            type: TargetType.time,
            target: time);
        FirebaseHelper.targetCollection
            .doc(timeTargetId)
            .set(timeTarget.toJson());

        Target waterTarget = Target(
            userId: FirebaseHelper.userId,
            id: waterTargetId,
            time: DateTime.now(),
            type: TargetType.water,
            target: water);
        FirebaseHelper.targetCollection
            .doc(waterTargetId)
            .set(waterTarget.toJson());
      }
    }
  }

  static Stream<Target?> getTarget(
      TargetType targetType, DateTime dateTime, String userId) {
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

        if (documentTime.year == dateTime.year &&
            documentTime.month == dateTime.month &&
            documentTime.day == dateTime.day &&
            targetType == TargetType.values.byName(type) &&
            userId == documentSnapshot.get("userId").toString()) {
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

  static Future<void> updateTarget(String id, double target) async {
    await FirebaseHelper.targetCollection.doc(id).update({"target": target});
  }

  static Future<void> updateReached(String id, double reached) async {
    await FirebaseHelper.targetCollection.doc(id).update({"reached": reached});
  }

  static double calculateCalo(int weight, int height, String gender, int age) {
    double calo = 0;
    if (gender == 'male') {
      calo = 88.362 + (13.397 * weight) + 4.799 * height - 5.677 * age;
    } else {
      calo = 447.593 + (9.247 * weight) + 3.098 * height - 4.33 * age;
    }
    return calo;
  }

  static Stream<List<Map<String, dynamic>>> getWeekTargets() {
    DateTime dateTime = DateTime.now();
    int day = dateTime.weekday;
    int count = 1;
    StreamController<List<Map<String, dynamic>>> streamController =
        StreamController<List<Map<String, dynamic>>>();
    List<Map<String, dynamic>> listReached = [];
    FirebaseHelper.targetCollection.snapshots().listen((querySnapshot) {
      while (count <= 7) {
        int temp = day - count;
        DateTime time;
        if (temp > 0) {
          time = dateTime.subtract(Duration(days: temp));
        } else {
          time = dateTime.add(Duration(days: temp.abs()));
        }
        bool isExist = false;
        for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
            in querySnapshot.docs) {
          Timestamp timestamp = documentSnapshot.get('time');
          String type = documentSnapshot.get("type");
          DateTime documentTime = DateTime.fromMillisecondsSinceEpoch(
              timestamp.millisecondsSinceEpoch);
          if (documentTime.year == time.year &&
              documentTime.month == time.month &&
              documentTime.day == time.day &&
              type == "step") {
            listReached.add({
              "index": count - 1,
              "target": documentSnapshot.get("target").toDouble(),
              "reached": documentSnapshot.get("reached").toDouble()
            });
            isExist = true;
          }
        }
        if (!isExist)
          listReached.add({"index": count - 1, "target": 3000, "reached": 0});
        count++;
      }
      streamController.add(listReached);
      print(listReached);
    });
    return streamController.stream;
  }

  static Stream<double> getWeekTotalReached(TargetType targetType) {
    DateTime dateTime = DateTime.now();
    int day = dateTime.weekday;
    int count = 1;
    StreamController<double> streamController = StreamController<double>();
    double total = 0;
    FirebaseHelper.targetCollection.snapshots().listen((querySnapshot) {
      while (count <= 7) {
        int temp = day - count;
        DateTime time;
        if (temp > 0) {
          time = dateTime.subtract(Duration(days: temp));
        } else {
          time = dateTime.add(Duration(days: temp.abs()));
        }

        for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
            in querySnapshot.docs) {
          Timestamp timestamp = documentSnapshot.get('time');
          String type = documentSnapshot.get("type");
          DateTime documentTime = DateTime.fromMillisecondsSinceEpoch(
              timestamp.millisecondsSinceEpoch);
          if (documentTime.year == time.year &&
              documentTime.month == time.month &&
              documentTime.day == time.day &&
              targetType == TargetType.values.byName(type)) {
            total += documentSnapshot.get("reached").toDouble();
          }
        }
        count++;
      }
      streamController.add(total);
      print(total);
    });
    return streamController.stream;
  }
}
