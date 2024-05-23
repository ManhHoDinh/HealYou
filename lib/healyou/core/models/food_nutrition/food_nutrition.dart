import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_nutrition.freezed.dart';
part 'food_nutrition.g.dart';
@freezed
class FoodNutrition with _$FoodNutrition {
  const factory FoodNutrition({
     String? name,
     String? calories,
    @JsonKey(name: 'serving_size_g')  double? servingSizeG,
    @JsonKey(name: 'fat_total_g')  double? fatTotalG,
    @JsonKey(name: 'fat_saturated_g')  double? fatSaturatedG,
     double? proteinG,
     int? sodiumMg,
     int? potassiumMg,
     int? cholesterolMg,
    @JsonKey(name: 'carbohydrates_total_g')  double? carbohydratesTotalG,
     double? fiberG,
     double? sugarG,
     String? quality,
    
  }) = _FoodNutrition;

  factory FoodNutrition.fromJson(Map<String, dynamic> json) => _$FoodNutritionFromJson(json);
}