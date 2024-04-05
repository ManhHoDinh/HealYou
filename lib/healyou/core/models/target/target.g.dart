// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TargetImpl _$$TargetImplFromJson(Map<String, dynamic> json) => _$TargetImpl(
      id: json['id'] as String,
      type: $enumDecode(_$TargetTypeEnumMap, json['type']),
      target: json['target'] as int,
      reached: json['reached'] as int,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TargetImplToJson(_$TargetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$TargetTypeEnumMap[instance.type]!,
      'target': instance.target,
      'reached': instance.reached,
      'user': instance.user,
    };

const _$TargetTypeEnumMap = {
  TargetType.step: 'step',
  TargetType.distance: 'distance',
  TargetType.time: 'time',
  TargetType.kcal: 'kcal',
  TargetType.water: 'water',
};
