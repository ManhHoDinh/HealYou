import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:healyou/healyou/core/models/target/target.dart';
import 'package:healyou/healyou/core/models/user/user.dart';
part 'water_target_item.g.dart';
part 'water_target_item.freezed.dart';

@Freezed()
class WaterTargetItem with _$WaterTargetItem {
  const factory WaterTargetItem({
    required String id,
    required DateTime time,
    required int target,
    required bool isNotify,
    @Default(null) Target? waterTarget,
  }) = _WaterTargetItem;
  factory WaterTargetItem.fromJson(Map<String, dynamic> json) =>
      _$WaterTargetItemFromJson(json);
}

enum WaterTargetItemType { step, distance, time, kcal, water }
