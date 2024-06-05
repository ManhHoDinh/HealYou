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
      targetWeight: json['targetWeight'] as int? ?? 0,
      gender: json['gender'] as String? ?? "",
      weight: json['weight'] as int? ?? 0,
      height: json['height'] as int? ?? 0,
      activity: json['activity'] as String? ?? "",
      mealPerDay: json['mealPerDay'] as int? ?? 3,
      weightLoss: json['weightLoss'] as String? ?? "",
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
    };
