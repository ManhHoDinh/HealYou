import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @Default("") String id,
    @Default("") String name,
    @Default("") String phoneNumber,
    @Default("") String email,
    @Default(0) int age,
    @Default(0) int weight,
    @Default(0) int height,
    @Default("") String gender,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}
