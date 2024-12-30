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
      age: (json['age'] as num?)?.toInt() ?? 0,
      targetWeight: (json['targetWeight'] as num?)?.toInt() ?? 0,
      gender: json['gender'] as String? ?? "",
      weight: (json['weight'] as num?)?.toInt() ?? 0,
      height: (json['height'] as num?)?.toInt() ?? 0,
      activity: json['activity'] as String? ?? "",
      mealPerDay: (json['mealPerDay'] as num?)?.toInt() ?? 3,
      weightLoss: json['weightLoss'] as String? ?? "",
      stepTarget: (json['stepTarget'] as num?)?.toInt() ?? 1000,
      verified: json['verified'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'age': instance.age,
      'targetWeight': instance.targetWeight,
      'gender': instance.gender,
      'weight': instance.weight,
      'height': instance.height,
      'activity': instance.activity,
      'mealPerDay': instance.mealPerDay,
      'weightLoss': instance.weightLoss,
      'verified': instance.verified,
      'stepTarget': instance.stepTarget,
    };
