import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:healyou/healyou/core/models/user/user.dart';
part 'target.g.dart';
part 'target.freezed.dart';

@Freezed()
class Target with _$Target {
  const factory Target({
    required String id,
    required TargetType type,
    required int target,
    required int reached,
    @Default(null) UserModel? user,
  }) = _Target;
  factory Target.fromJson(Map<String, dynamic> json) => _$TargetFromJson(json);
}

enum TargetType { step, distance, time, kcal, water }
