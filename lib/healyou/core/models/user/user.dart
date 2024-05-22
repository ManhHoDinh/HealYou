import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel(
      {@Default("") String id,
      @Default("") String name,
      @Default("") String phoneNumber,
      @Default("") String email,
      @Default(0) int age,
      @Default(0) int targetWeight,
      @Default("") String gender,
      @Default(0) int weight,
      @Default(0) int height,
      @Default("") String activity,
      @Default(3) int mealPerDay,
      @Default("") String weightLoss}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
