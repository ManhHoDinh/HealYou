// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DishImpl _$$DishImplFromJson(Map<String, dynamic> json) => _$DishImpl(
      RecipeId: json['RecipeId'] as int? ?? 0,
      Name: json['Name'] as String? ?? "",
      CookTime: json['CookTime'] as String? ?? "",
      PrepTime: json['PrepTime'] as String? ?? "",
      TotalTime: json['TotalTime'] as String? ?? "",
      RecipeIngredientParts: (json['RecipeIngredientParts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      Calories: (json['Calories'] as num?)?.toDouble() ?? 0,
      FatContent: (json['FatContent'] as num?)?.toDouble() ?? 0,
      SaturatedFatContent:
          (json['SaturatedFatContent'] as num?)?.toDouble() ?? 0,
      CholesterolContent: (json['CholesterolContent'] as num?)?.toDouble() ?? 0,
      SodiumContent: (json['SodiumContent'] as num?)?.toDouble() ?? 0,
      CarbohydrateContent:
          (json['CarbohydrateContent'] as num?)?.toDouble() ?? 0,
      FiberContent: (json['FiberContent'] as num?)?.toDouble() ?? 0,
      SugarContent: (json['SugarContent'] as num?)?.toDouble() ?? 0,
      ProteinContent: (json['ProteinContent'] as num?)?.toDouble() ?? 0,
      imageLink: json['image_link'] as String? ?? "",
      RecipeInstructions: (json['RecipeInstructions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$DishImplToJson(_$DishImpl instance) =>
    <String, dynamic>{
      'RecipeId': instance.RecipeId,
      'Name': instance.Name,
      'CookTime': instance.CookTime,
      'PrepTime': instance.PrepTime,
      'TotalTime': instance.TotalTime,
      'RecipeIngredientParts': instance.RecipeIngredientParts,
      'Calories': instance.Calories,
      'FatContent': instance.FatContent,
      'SaturatedFatContent': instance.SaturatedFatContent,
      'CholesterolContent': instance.CholesterolContent,
      'SodiumContent': instance.SodiumContent,
      'CarbohydrateContent': instance.CarbohydrateContent,
      'FiberContent': instance.FiberContent,
      'SugarContent': instance.SugarContent,
      'ProteinContent': instance.ProteinContent,
      'image_link': instance.imageLink,
      'RecipeInstructions': instance.RecipeInstructions,
    };
