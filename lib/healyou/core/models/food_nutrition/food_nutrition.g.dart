// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_nutrition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodNutritionImpl _$$FoodNutritionImplFromJson(Map<String, dynamic> json) =>
    _$FoodNutritionImpl(
      name: json['name'] as String?,
      calories: json['calories'] as String?,
      servingSizeG: (json['serving_size_g'] as num?)?.toDouble(),
      fatTotalG: (json['fat_total_g'] as num?)?.toDouble(),
      fatSaturatedG: (json['fat_saturated_g'] as num?)?.toDouble(),
      proteinG: (json['proteinG'] as num?)?.toDouble(),
      sodiumMg: (json['sodiumMg'] as num?)?.toInt(),
      potassiumMg: (json['potassiumMg'] as num?)?.toInt(),
      cholesterolMg: (json['cholesterolMg'] as num?)?.toInt(),
      carbohydratesTotalG: (json['carbohydrates_total_g'] as num?)?.toDouble(),
      fiberG: (json['fiberG'] as num?)?.toDouble(),
      sugarG: (json['sugarG'] as num?)?.toDouble(),
      quality: json['quality'] as String?,
    );

Map<String, dynamic> _$$FoodNutritionImplToJson(_$FoodNutritionImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'calories': instance.calories,
      'serving_size_g': instance.servingSizeG,
      'fat_total_g': instance.fatTotalG,
      'fat_saturated_g': instance.fatSaturatedG,
      'proteinG': instance.proteinG,
      'sodiumMg': instance.sodiumMg,
      'potassiumMg': instance.potassiumMg,
      'cholesterolMg': instance.cholesterolMg,
      'carbohydrates_total_g': instance.carbohydratesTotalG,
      'fiberG': instance.fiberG,
      'sugarG': instance.sugarG,
      'quality': instance.quality,
    };
