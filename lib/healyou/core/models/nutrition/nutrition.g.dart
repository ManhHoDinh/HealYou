// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NutritionImpl _$$NutritionImplFromJson(Map<String, dynamic> json) =>
    _$NutritionImpl(
      id: json['id'] as String? ?? "",
      name: json['name'] as String? ?? "",
      meal: json['meal'] as String? ?? "",
      calories: json['calories'] as String? ?? "",
      protein: json['protein'] as String? ?? "",
      fat: json['fat'] as String? ?? "",
      userId: json['userId'] as String? ?? "",
      time: _sendAtFromJson(json['time'] as Timestamp),
      foodItems: json['foodItems'] as List<dynamic>?,
    );

Map<String, dynamic> _$$NutritionImplToJson(_$NutritionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'meal': instance.meal,
      'calories': instance.calories,
      'protein': instance.protein,
      'fat': instance.fat,
      'userId': instance.userId,
      'time': _sendAtToJson(instance.time),
      'foodItems': instance.foodItems,
    };
