import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part "sleep.g.dart";
part "sleep.freezed.dart";

Color _sendColorFromJson(int color) => Color(color);

int _sendColorToJson(Color? color) => color!.value;

DateTime _sendDateTimeFromJson(Timestamp timestamp) =>
    DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);

Timestamp _sendDateTimeToJson(DateTime? time) => Timestamp.fromDate(time!);

List<DateTime> _sendSleepTimesListFromJson(List sleepTimes) =>
    sleepTimes.isNotEmpty
        ? sleepTimes.map((e) => _sendDateTimeFromJson(e)).toList()
        : [];

List<Timestamp> _sendSleepTimesListToJson(List sleepTimes) =>
    sleepTimes.isNotEmpty
        ? sleepTimes.map((e) => _sendDateTimeToJson(e)).toList()
        : [];

@Freezed()
class Sleep with _$Sleep {
  factory Sleep({
    @Default(null) String? id,
    @JsonKey(
        name: "startTime",
        fromJson: _sendDateTimeFromJson,
        toJson: _sendDateTimeToJson)
    required DateTime startTime,
    @JsonKey(
        name: "endTime",
        fromJson: _sendDateTimeFromJson,
        toJson: _sendDateTimeToJson)
    required DateTime endTime,
    @JsonKey(
        name: "color", fromJson: _sendColorFromJson, toJson: _sendColorToJson)
    @Default(Colors.greenAccent)
    Color? color,
    @JsonKey(
        name: "sleepTime",
        fromJson: _sendSleepTimesListFromJson,
        toJson: _sendSleepTimesListToJson)
    @Default(<DateTime>[])
    List<DateTime> sleepTime,
  }) = _Sleep;
  factory Sleep.fromJson(Map<String, dynamic> json) => _$SleepFromJson(json);
}
