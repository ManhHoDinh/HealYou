// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_target_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WaterTargetItemImpl _$$WaterTargetItemImplFromJson(
        Map<String, dynamic> json) =>
    _$WaterTargetItemImpl(
      id: json['id'] as String? ?? "",
      time: _sendAtFromJson(json['time'] as Timestamp),
      target: json['target'] as int? ?? 0,
      isNotify: json['isNotify'] as bool? ?? false,
      waterTargetId: json['waterTargetId'] as String? ?? "",
    );

Map<String, dynamic> _$$WaterTargetItemImplToJson(
        _$WaterTargetItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time?.toIso8601String(),
      'target': instance.target,
      'isNotify': instance.isNotify,
      'waterTargetId': instance.waterTargetId,
    };
