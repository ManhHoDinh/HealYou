import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'water_target_item.g.dart';
part 'water_target_item.freezed.dart';

DateTime _sendAtFromJson(Timestamp timestamp) =>
    DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch,
        isUtc: true);

@Freezed()
class WaterTargetItem with _$WaterTargetItem {
  const factory WaterTargetItem(
      {@Default("") String id,
      @JsonKey(name: "time", fromJson: _sendAtFromJson) DateTime? time,
      @Default(0) int target,
      @Default(false) bool isNotify,
      @Default("") String waterTargetId,
      @Default("") String userId}) = _WaterTargetItem;
  factory WaterTargetItem.fromJson(Map<String, dynamic> json) =>
      _$WaterTargetItemFromJson(json);
}

enum WaterTargetItemType { step, distance, time, kcal, water }
