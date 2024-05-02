// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String? ?? "",
      name: json['name'] as String? ?? "",
      phoneNumber: json['phoneNumber'] as String? ?? "",
      email: json['email'] as String? ?? "",
      age: json['age'] as int? ?? 0,
      weight: json['weight'] as int? ?? 0,
      targetWeight: json['targetWeight'] as int? ?? 0,
      activity: (json['activity'] as num?)?.toDouble() ?? 0,
      weightLoss: (json['weightLoss'] as num?)?.toDouble() ?? 0,
      height: json['height'] as int? ?? 0,
      gender: json['gender'] as String? ?? "",
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'age': instance.age,
      'weight': instance.weight,
      'targetWeight': instance.targetWeight,
      'activity': instance.activity,
      'weightLoss': instance.weightLoss,
      'height': instance.height,
      'gender': instance.gender,
    };
