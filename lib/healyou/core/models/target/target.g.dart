// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TargetImpl _$$TargetImplFromJson(Map<String, dynamic> json) => _$TargetImpl(
      id: json['id'] as String? ?? "",
      type: $enumDecodeNullable(_$TargetTypeEnumMap, json['type']) ??
          TargetType.step,
      target: json['target'] as int? ?? 0,
      reached: json['reached'] as int? ?? 0,
      userId: json['userId'] as String? ?? "",
      time: _sendAtFromJson(json['time'] as Timestamp),
    );

Map<String, dynamic> _$$TargetImplToJson(_$TargetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$TargetTypeEnumMap[instance.type]!,
      'target': instance.target,
      'reached': instance.reached,
      'userId': instance.userId,
      'time': _sendAtToJson(instance.time),
    };

const _$TargetTypeEnumMap = {
  TargetType.step: 'step',
  TargetType.distance: 'distance',
  TargetType.time: 'time',
  TargetType.kcal: 'kcal',
  TargetType.water: 'water',
};
