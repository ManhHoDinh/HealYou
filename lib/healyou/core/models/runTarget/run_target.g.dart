// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_target.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RunTargetImpl _$$RunTargetImplFromJson(Map<String, dynamic> json) =>
    _$RunTargetImpl(
      id: json['id'] as String,
      type: $enumDecode(_$TargetTypeEnumMap, json['type']),
      target: json['target'] as int,
      reached: json['reached'] as int,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RunTargetImplToJson(_$RunTargetImpl instance) =>
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
};
