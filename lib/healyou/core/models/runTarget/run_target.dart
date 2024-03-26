import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:healyou/healyou/core/models/user/user.dart';
part 'run_target.g.dart';
part 'run_target.freezed.dart';

@Freezed()
class RunTarget with _$RunTarget {
  const factory RunTarget({
    required String id,
    required TargetType type,
    required int target,
    required int reached,
    required UserModel user,
  }) = _RunTarget;
  factory RunTarget.fromJson(Map<String, dynamic> json) =>
      _$RunTargetFromJson(json);
}

enum TargetType { step, distance, time, kcal }
