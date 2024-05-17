// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'dish.freezed.dart';
part 'dish.g.dart';

@freezed
class Dish with _$Dish {
  const factory Dish({
    @Default(0) int RecipeId,
    @Default("") String Name,
    @Default("") String CookTime,
    @Default("") String PrepTime,
    @Default("") String TotalTime,
    @Default([]) List<String> RecipeIngredientParts,
    @Default(0) double Calories,
    @Default(0) double FatContent,
    @Default(0) double SaturatedFatContent,
    @Default(0) double CholesterolContent,
    @Default(0) double SodiumContent,
    @Default(0) double CarbohydrateContent,
    @Default(0) double FiberContent,
    @Default(0) double SugarContent,
    @Default(0) double ProteinContent,
    @Default("") @JsonKey(name: "image_link") String imageLink,
    @Default([]) List<String> RecipeInstructions,
  }) = _Dish;

  factory Dish.fromJson(Map<String, Object?> json) => _$DishFromJson(json);
}
