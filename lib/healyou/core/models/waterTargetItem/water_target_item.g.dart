// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_target_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WaterTargetItemImpl _$$WaterTargetItemImplFromJson(
        Map<String, dynamic> json) =>
    _$WaterTargetItemImpl(
      id: json['id'] as String,
      time: DateTime.parse(json['time'] as String),
      target: json['target'] as int,
      isNotify: json['isNotify'] as bool,
      waterTarget: json['waterTarget'] == null
          ? null
          : Target.fromJson(json['waterTarget'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WaterTargetItemImplToJson(
        _$WaterTargetItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time.toIso8601String(),
      'target': instance.target,
      'isNotify': instance.isNotify,
      'waterTarget': instance.waterTarget,
    };
