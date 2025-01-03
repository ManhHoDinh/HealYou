import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'nutrition.g.dart';
part 'nutrition.freezed.dart';

DateTime _sendAtFromJson(Timestamp timestamp) =>
    DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);

Timestamp _sendAtToJson(DateTime? time) => Timestamp.fromDate(time!);

@Freezed()
class Nutrition with _$Nutrition {
  const factory Nutrition({
    @Default("") String id,
    @Default("") String name,
    @Default("") String meal,
    @Default("") String calories,
    @Default("") String protein,
    @Default("") String fat,
    @Default("") String userId,
    @JsonKey(name: "time", fromJson: _sendAtFromJson, toJson: _sendAtToJson)
    DateTime? time,
    List<dynamic>? foodItems,
  }) = _Nutrition;
  factory Nutrition.fromJson(Map<String, dynamic> json) =>
      _$NutritionFromJson(json);
}
