import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_detect.freezed.dart';
part 'food_detect.g.dart';

@freezed
class FoodDetect with _$FoodDetect {
  factory FoodDetect({
    @JsonKey(name: 'analysis_id') required String AnalysisId,
    required List<Item> items,
    required List<String> scopes,
    @JsonKey(name: 'nutritionalFacts') NutritionalFacts? nutritionalFacts,
  }) = _FoodDetect;

  factory FoodDetect.fromJson(Map<String, dynamic> json) =>
      _$FoodDetectFromJson(json);
}

@freezed
class Item with _$Item {
  factory Item({
    List<Food>? food,
    Position? position,
    String? color,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class Food with _$Food {
  factory Food({
    double? confidence,
    double? quantity,
    @JsonKey(name: 'food_info') required FoodInfo foodInfo,
    @JsonKey(name: 'nutritionalFacts') NutritionalFacts? nutritionalFacts,
  }) = _Food;

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
}

@freezed
class FoodInfo with _$FoodInfo {
  factory FoodInfo({
    @JsonKey(name: 'food_id') required String foodId,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'g_per_serving') required double gPerServing,
    @JsonKey(name: 'fv_grade') required String fvGrade,
    Nutrition? nutrition,
  }) = _FoodInfo;

  factory FoodInfo.fromJson(Map<String, dynamic> json) =>
      _$FoodInfoFromJson(json);
}

@freezed
class Nutrition with _$Nutrition {
  factory Nutrition({
    double? alcohol100g,
    double? calcium100g,
    double? calories100g,
    double? carbs100g,
    double? chloride100g,
    double? cholesterol100g,
    // ... add all other nutrition fields here
  }) = _Nutrition;

  factory Nutrition.fromJson(Map<String, dynamic> json) =>
      _$NutritionFromJson(json);
}

@freezed
class NutritionalFacts with _$NutritionalFacts {
  factory NutritionalFacts({
    required double calories,
    required double fat,
    required double proteins,
    required double carbs,
    required double fibers,
    // ... add all other nutritional facts fields here
  }) = _NutritionalFacts;

  factory NutritionalFacts.fromJson(Map<String, dynamic> json) =>
      _$NutritionalFactsFromJson(json);
}

@freezed
class Position with _$Position {
  factory Position({
    required double x,
    required double y,
    required double width,
    required double height,
  }) = _Position;

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);
}
