// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_detect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodDetectImpl _$$FoodDetectImplFromJson(Map<String, dynamic> json) =>
    _$FoodDetectImpl(
      AnalysisId: json['analysis_id'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      scopes:
          (json['scopes'] as List<dynamic>).map((e) => e as String).toList(),
      nutritionalFacts: json['nutritionalFacts'] == null
          ? null
          : NutritionalFacts.fromJson(
              json['nutritionalFacts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FoodDetectImplToJson(_$FoodDetectImpl instance) =>
    <String, dynamic>{
      'analysis_id': instance.AnalysisId,
      'items': instance.items,
      'scopes': instance.scopes,
      'nutritionalFacts': instance.nutritionalFacts,
    };

_$ItemImpl _$$ItemImplFromJson(Map<String, dynamic> json) => _$ItemImpl(
      food: (json['food'] as List<dynamic>?)
          ?.map((e) => Food.fromJson(e as Map<String, dynamic>))
          .toList(),
      position: json['position'] == null
          ? null
          : Position.fromJson(json['position'] as Map<String, dynamic>),
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$ItemImplToJson(_$ItemImpl instance) =>
    <String, dynamic>{
      'food': instance.food,
      'position': instance.position,
      'color': instance.color,
    };

_$FoodImpl _$$FoodImplFromJson(Map<String, dynamic> json) => _$FoodImpl(
      confidence: (json['confidence'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      foodInfo: FoodInfo.fromJson(json['food_info'] as Map<String, dynamic>),
      nutritionalFacts: json['nutritionalFacts'] == null
          ? null
          : NutritionalFacts.fromJson(
              json['nutritionalFacts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FoodImplToJson(_$FoodImpl instance) =>
    <String, dynamic>{
      'confidence': instance.confidence,
      'quantity': instance.quantity,
      'food_info': instance.foodInfo,
      'nutritionalFacts': instance.nutritionalFacts,
    };

_$FoodInfoImpl _$$FoodInfoImplFromJson(Map<String, dynamic> json) =>
    _$FoodInfoImpl(
      foodId: json['food_id'] as String,
      displayName: json['display_name'] as String,
      gPerServing: (json['g_per_serving'] as num).toDouble(),
      fvGrade: json['fv_grade'] as String,
      nutrition: json['nutrition'] == null
          ? null
          : Nutrition.fromJson(json['nutrition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FoodInfoImplToJson(_$FoodInfoImpl instance) =>
    <String, dynamic>{
      'food_id': instance.foodId,
      'display_name': instance.displayName,
      'g_per_serving': instance.gPerServing,
      'fv_grade': instance.fvGrade,
      'nutrition': instance.nutrition,
    };

_$NutritionImpl _$$NutritionImplFromJson(Map<String, dynamic> json) =>
    _$NutritionImpl(
      alcohol100g: (json['alcohol100g'] as num?)?.toDouble(),
      calcium100g: (json['calcium100g'] as num?)?.toDouble(),
      calories100g: (json['calories100g'] as num?)?.toDouble(),
      carbs100g: (json['carbs100g'] as num?)?.toDouble(),
      chloride100g: (json['chloride100g'] as num?)?.toDouble(),
      cholesterol100g: (json['cholesterol100g'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$NutritionImplToJson(_$NutritionImpl instance) =>
    <String, dynamic>{
      'alcohol100g': instance.alcohol100g,
      'calcium100g': instance.calcium100g,
      'calories100g': instance.calories100g,
      'carbs100g': instance.carbs100g,
      'chloride100g': instance.chloride100g,
      'cholesterol100g': instance.cholesterol100g,
    };

_$NutritionalFactsImpl _$$NutritionalFactsImplFromJson(
        Map<String, dynamic> json) =>
    _$NutritionalFactsImpl(
      calories: (json['calories'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      proteins: (json['proteins'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fibers: (json['fibers'] as num).toDouble(),
    );

Map<String, dynamic> _$$NutritionalFactsImplToJson(
        _$NutritionalFactsImpl instance) =>
    <String, dynamic>{
      'calories': instance.calories,
      'fat': instance.fat,
      'proteins': instance.proteins,
      'carbs': instance.carbs,
      'fibers': instance.fibers,
    };

_$PositionImpl _$$PositionImplFromJson(Map<String, dynamic> json) =>
    _$PositionImpl(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );

Map<String, dynamic> _$$PositionImplToJson(_$PositionImpl instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
    };
