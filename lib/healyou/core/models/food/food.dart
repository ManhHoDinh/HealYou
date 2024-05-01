import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'food.freezed.dart';
part 'food.g.dart';

@freezed
class FoodModel with _$FoodModel {
  const factory FoodModel({
    required String Id,
    required String Name,
    required String Weight,
    required String ImageLink,
    required String Description,
    required String url,
  }) = _FoodModel;

  factory FoodModel.fromJson(Map<String, Object?> json) =>
      _$FoodModelFromJson(json);
}
