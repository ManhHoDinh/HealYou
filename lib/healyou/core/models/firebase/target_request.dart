import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healyou/healyou/core/helper/firebase_helper.dart';
import 'package:healyou/healyou/core/models/display/display.dart';
import 'package:healyou/healyou/core/models/firebase/user_request.dart';
import 'package:healyou/healyou/core/models/target/target.dart';
import 'package:healyou/healyou/core/models/user/user.dart';
import 'package:quiver/time.dart';

class TargetRequest {
  static double averageCompletion = 0;
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
        String userId = FirebaseAuth.instance.currentUser!.uid;

        DateTime documentTime = DateTime.fromMillisecondsSinceEpoch(
            timestamp.millisecondsSinceEpoch);
        DateTime currentTime = DateTime.now();
        if (documentTime.year == currentTime.year &&
            documentTime.month == currentTime.month &&
            documentTime.day == currentTime.day &&
            userId == documentSnapshot.get('userId').toString()) {
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
    String userId = FirebaseAuth.instance.currentUser!.uid;
    UserModel? user = await UserRequest.getById(userId).first;
    print(user);
    if (user!.age != 0 &&
        user!.height != 0 &&
        user.weight != 0 &&
        user.gender != "") {
      Display display = Display();
      String runTargetId = await FirebaseHelper.targetCollection.doc().id;
      String kcalTargetId = await FirebaseHelper.targetCollection.doc().id;
      String kmTargetId = await FirebaseHelper.targetCollection.doc().id;
      String timeTargetId = await FirebaseHelper.targetCollection.doc().id;
      String waterTargetId = await FirebaseHelper.targetCollection.doc().id;
      double caloTarget =
          calculateCalo(user!.weight, user.height, user.gender, user.age) *
              display.getActivityLevel(user.activity) *
              display.getWeightLoss(user.weightLoss).round().toDouble();
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
            userId: userId,
            id: runTargetId,
            time: DateTime.now(),
            type: TargetType.step,
            target: stepTarget);
        FirebaseHelper.targetCollection
            .doc(runTargetId)
            .set(runTarget.toJson());
        Target kcalTarget = Target(
            userId: userId,
            id: kcalTargetId,
            time: DateTime.now(),
            type: TargetType.kcal,
            target: caloTarget);
        FirebaseHelper.targetCollection
            .doc(kcalTargetId)
            .set(kcalTarget.toJson());
        Target kmTarget = Target(
            userId: userId,
            id: kmTargetId,
            time: DateTime.now(),
            type: TargetType.distance,
            target: distanceTarget);
        FirebaseHelper.targetCollection.doc(kmTargetId).set(kmTarget.toJson());
        Target timeTarget = Target(
            userId: userId,
            id: timeTargetId,
            time: DateTime.now(),
            type: TargetType.time,
            target: time);
        FirebaseHelper.targetCollection
            .doc(timeTargetId)
            .set(timeTarget.toJson());

        Target waterTarget = Target(
            userId: userId,
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

  static Future<Target?> getAllTarget(
    TargetType targetType,
  ) {
    return FirebaseHelper.targetCollection
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("type", isEqualTo: targetType)
        .get()
        .then((value) => Target.fromJson(value.docs[0].data()));
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
      calo = (10 * weight) + 6.25 * height - 5 * age + 5;
    } else {
      calo = (10 * weight) + 6.25 * height - 5 * age - 161;
    }
    return calo;
  }

  static Stream<List<Map<String, dynamic>>> getWeekTargets() {
    DateTime dateTime = DateTime.now();
    int day = dateTime.weekday;
    int count = 1;
    String userId = FirebaseAuth.instance.currentUser!.uid;
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
              userId == documentSnapshot.get("userId") &&
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
    String userId = FirebaseAuth.instance.currentUser!.uid;
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
              userId == documentSnapshot.get("userId") &&
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

  static Stream<List<double>> waterStatistic(
      TargetType targetType, DateTime usedTime) {
    DateTime dateTime = DateTime.now();
    String userId = FirebaseAuth.instance.currentUser!.uid;

    int count = 0;
    StreamController<List<double>> streamController =
        StreamController<List<double>>();

    FirebaseHelper.targetCollection.snapshots().listen((querySnapshot) {
      List<double> listData = [];
      int dayInMonth = daysInMonth(usedTime.year, usedTime.month);

      while (count <= dayInMonth) {
        DateTime time = DateTime.utc(usedTime.year, usedTime.month, count);
        bool isHasData = false;
        for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
            in querySnapshot.docs) {
          Timestamp timestamp = documentSnapshot.get('time');
          String type = documentSnapshot.get("type");
          DateTime documentTime = DateTime.fromMillisecondsSinceEpoch(
              timestamp.millisecondsSinceEpoch);
          if (documentTime.year == time.year &&
              documentTime.month == time.month &&
              documentTime.day == time.day &&
              userId == documentSnapshot.get("userId") &&
              targetType == TargetType.values.byName(type)) {
            double reached = documentSnapshot.get("reached").toDouble();
            double target = documentSnapshot.get("target").toDouble();
            listData.add(reached * 100 / target);
            isHasData = true;
          }
        }
        if (!isHasData) {
          listData.add(0);
        }
        count++;
      }
      streamController.add(listData);
    });
    return streamController.stream;
  }

  static Future<List<DateTime>> getRangeWaterStatistic() async {
    var data = await FirebaseHelper.targetCollection.orderBy("time").get();
    List<Target> targets = [];
    String userId = FirebaseAuth.instance.currentUser!.uid;

    double average = 0;
    for (var doc in data.docs) {
      Target targetDoc = Target.fromJson(doc.data());
      if (targetDoc.type == TargetType.values.byName("water") &&
          userId == targetDoc.userId) {
        average += targetDoc.reached * 100 / targetDoc.target;
        targets.add(targetDoc);
      }
    }
    averageCompletion = average / targets.length;
    Target startRangeTarget = targets[0];
    Target endRangeTarget = targets[targets.length - 1];
    return [startRangeTarget.time!, endRangeTarget.time!];
  }
}
