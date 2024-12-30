import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'target.g.dart';
part 'target.freezed.dart';

DateTime _sendAtFromJson(Timestamp timestamp) =>
    DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);

Timestamp _sendAtToJson(DateTime? time) => Timestamp.fromDate(time!);

@Freezed()
class Target with _$Target {
  const factory Target({
    @Default("") String id,
    @Default(TargetType.step) TargetType type,
    @Default(0) double target,
    @Default(0) double reached,
    @Default("") String userId,
    @JsonKey(name: "time", fromJson: _sendAtFromJson, toJson: _sendAtToJson)
    DateTime? time,
  }) = _Target;
  factory Target.fromJson(Map<String, dynamic> json) => _$TargetFromJson(json);
}

enum TargetType { step, distance, time, kcal, water }
