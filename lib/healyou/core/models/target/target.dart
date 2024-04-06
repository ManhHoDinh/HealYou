import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:healyou/healyou/core/models/user/user.dart';
part 'target.g.dart';
part 'target.freezed.dart';

DateTime _sendAtFromJson(Timestamp timestamp) =>
    DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);

@Freezed()
class Target with _$Target {
  const factory Target({
    @Default("") String id,
    @Default(TargetType.step) TargetType type,
    @Default(0) int target,
    @Default(0) int reached,
    @Default("") String userId,
    @JsonKey(name: "time", fromJson: _sendAtFromJson) DateTime? time,
  }) = _Target;
  factory Target.fromJson(Map<String, dynamic> json) => _$TargetFromJson(json);
}

enum TargetType { step, distance, time, kcal, water }
