// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_nutrition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FoodNutrition _$FoodNutritionFromJson(Map<String, dynamic> json) {
  return _FoodNutrition.fromJson(json);
}

/// @nodoc
mixin _$FoodNutrition {
  String? get name => throw _privateConstructorUsedError;
  String? get calories => throw _privateConstructorUsedError;
  @JsonKey(name: 'serving_size_g')
  double? get servingSizeG => throw _privateConstructorUsedError;
  @JsonKey(name: 'fat_total_g')
  double? get fatTotalG => throw _privateConstructorUsedError;
  @JsonKey(name: 'fat_saturated_g')
  double? get fatSaturatedG => throw _privateConstructorUsedError;
  double? get proteinG => throw _privateConstructorUsedError;
  int? get sodiumMg => throw _privateConstructorUsedError;
  int? get potassiumMg => throw _privateConstructorUsedError;
  int? get cholesterolMg => throw _privateConstructorUsedError;
  @JsonKey(name: 'carbohydrates_total_g')
  double? get carbohydratesTotalG => throw _privateConstructorUsedError;
  double? get fiberG => throw _privateConstructorUsedError;
  double? get sugarG => throw _privateConstructorUsedError;
  String? get quality => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodNutritionCopyWith<FoodNutrition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodNutritionCopyWith<$Res> {
  factory $FoodNutritionCopyWith(
          FoodNutrition value, $Res Function(FoodNutrition) then) =
      _$FoodNutritionCopyWithImpl<$Res, FoodNutrition>;
  @useResult
  $Res call(
      {String? name,
      String? calories,
      @JsonKey(name: 'serving_size_g') double? servingSizeG,
      @JsonKey(name: 'fat_total_g') double? fatTotalG,
      @JsonKey(name: 'fat_saturated_g') double? fatSaturatedG,
      double? proteinG,
      int? sodiumMg,
      int? potassiumMg,
      int? cholesterolMg,
      @JsonKey(name: 'carbohydrates_total_g') double? carbohydratesTotalG,
      double? fiberG,
      double? sugarG,
      String? quality});
}

/// @nodoc
class _$FoodNutritionCopyWithImpl<$Res, $Val extends FoodNutrition>
    implements $FoodNutritionCopyWith<$Res> {
  _$FoodNutritionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? calories = freezed,
    Object? servingSizeG = freezed,
    Object? fatTotalG = freezed,
    Object? fatSaturatedG = freezed,
    Object? proteinG = freezed,
    Object? sodiumMg = freezed,
    Object? potassiumMg = freezed,
    Object? cholesterolMg = freezed,
    Object? carbohydratesTotalG = freezed,
    Object? fiberG = freezed,
    Object? sugarG = freezed,
    Object? quality = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      calories: freezed == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as String?,
      servingSizeG: freezed == servingSizeG
          ? _value.servingSizeG
          : servingSizeG // ignore: cast_nullable_to_non_nullable
              as double?,
      fatTotalG: freezed == fatTotalG
          ? _value.fatTotalG
          : fatTotalG // ignore: cast_nullable_to_non_nullable
              as double?,
      fatSaturatedG: freezed == fatSaturatedG
          ? _value.fatSaturatedG
          : fatSaturatedG // ignore: cast_nullable_to_non_nullable
              as double?,
      proteinG: freezed == proteinG
          ? _value.proteinG
          : proteinG // ignore: cast_nullable_to_non_nullable
              as double?,
      sodiumMg: freezed == sodiumMg
          ? _value.sodiumMg
          : sodiumMg // ignore: cast_nullable_to_non_nullable
              as int?,
      potassiumMg: freezed == potassiumMg
          ? _value.potassiumMg
          : potassiumMg // ignore: cast_nullable_to_non_nullable
              as int?,
      cholesterolMg: freezed == cholesterolMg
          ? _value.cholesterolMg
          : cholesterolMg // ignore: cast_nullable_to_non_nullable
              as int?,
      carbohydratesTotalG: freezed == carbohydratesTotalG
          ? _value.carbohydratesTotalG
          : carbohydratesTotalG // ignore: cast_nullable_to_non_nullable
              as double?,
      fiberG: freezed == fiberG
          ? _value.fiberG
          : fiberG // ignore: cast_nullable_to_non_nullable
              as double?,
      sugarG: freezed == sugarG
          ? _value.sugarG
          : sugarG // ignore: cast_nullable_to_non_nullable
              as double?,
      quality: freezed == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FoodNutritionImplCopyWith<$Res>
    implements $FoodNutritionCopyWith<$Res> {
  factory _$$FoodNutritionImplCopyWith(
          _$FoodNutritionImpl value, $Res Function(_$FoodNutritionImpl) then) =
      __$$FoodNutritionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? calories,
      @JsonKey(name: 'serving_size_g') double? servingSizeG,
      @JsonKey(name: 'fat_total_g') double? fatTotalG,
      @JsonKey(name: 'fat_saturated_g') double? fatSaturatedG,
      double? proteinG,
      int? sodiumMg,
      int? potassiumMg,
      int? cholesterolMg,
      @JsonKey(name: 'carbohydrates_total_g') double? carbohydratesTotalG,
      double? fiberG,
      double? sugarG,
      String? quality});
}

/// @nodoc
class __$$FoodNutritionImplCopyWithImpl<$Res>
    extends _$FoodNutritionCopyWithImpl<$Res, _$FoodNutritionImpl>
    implements _$$FoodNutritionImplCopyWith<$Res> {
  __$$FoodNutritionImplCopyWithImpl(
      _$FoodNutritionImpl _value, $Res Function(_$FoodNutritionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? calories = freezed,
    Object? servingSizeG = freezed,
    Object? fatTotalG = freezed,
    Object? fatSaturatedG = freezed,
    Object? proteinG = freezed,
    Object? sodiumMg = freezed,
    Object? potassiumMg = freezed,
    Object? cholesterolMg = freezed,
    Object? carbohydratesTotalG = freezed,
    Object? fiberG = freezed,
    Object? sugarG = freezed,
    Object? quality = freezed,
  }) {
    return _then(_$FoodNutritionImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      calories: freezed == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as String?,
      servingSizeG: freezed == servingSizeG
          ? _value.servingSizeG
          : servingSizeG // ignore: cast_nullable_to_non_nullable
              as double?,
      fatTotalG: freezed == fatTotalG
          ? _value.fatTotalG
          : fatTotalG // ignore: cast_nullable_to_non_nullable
              as double?,
      fatSaturatedG: freezed == fatSaturatedG
          ? _value.fatSaturatedG
          : fatSaturatedG // ignore: cast_nullable_to_non_nullable
              as double?,
      proteinG: freezed == proteinG
          ? _value.proteinG
          : proteinG // ignore: cast_nullable_to_non_nullable
              as double?,
      sodiumMg: freezed == sodiumMg
          ? _value.sodiumMg
          : sodiumMg // ignore: cast_nullable_to_non_nullable
              as int?,
      potassiumMg: freezed == potassiumMg
          ? _value.potassiumMg
          : potassiumMg // ignore: cast_nullable_to_non_nullable
              as int?,
      cholesterolMg: freezed == cholesterolMg
          ? _value.cholesterolMg
          : cholesterolMg // ignore: cast_nullable_to_non_nullable
              as int?,
      carbohydratesTotalG: freezed == carbohydratesTotalG
          ? _value.carbohydratesTotalG
          : carbohydratesTotalG // ignore: cast_nullable_to_non_nullable
              as double?,
      fiberG: freezed == fiberG
          ? _value.fiberG
          : fiberG // ignore: cast_nullable_to_non_nullable
              as double?,
      sugarG: freezed == sugarG
          ? _value.sugarG
          : sugarG // ignore: cast_nullable_to_non_nullable
              as double?,
      quality: freezed == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodNutritionImpl implements _FoodNutrition {
  const _$FoodNutritionImpl(
      {this.name,
      this.calories,
      @JsonKey(name: 'serving_size_g') this.servingSizeG,
      @JsonKey(name: 'fat_total_g') this.fatTotalG,
      @JsonKey(name: 'fat_saturated_g') this.fatSaturatedG,
      this.proteinG,
      this.sodiumMg,
      this.potassiumMg,
      this.cholesterolMg,
      @JsonKey(name: 'carbohydrates_total_g') this.carbohydratesTotalG,
      this.fiberG,
      this.sugarG,
      this.quality});

  factory _$FoodNutritionImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodNutritionImplFromJson(json);

  @override
  final String? name;
  @override
  final String? calories;
  @override
  @JsonKey(name: 'serving_size_g')
  final double? servingSizeG;
  @override
  @JsonKey(name: 'fat_total_g')
  final double? fatTotalG;
  @override
  @JsonKey(name: 'fat_saturated_g')
  final double? fatSaturatedG;
  @override
  final double? proteinG;
  @override
  final int? sodiumMg;
  @override
  final int? potassiumMg;
  @override
  final int? cholesterolMg;
  @override
  @JsonKey(name: 'carbohydrates_total_g')
  final double? carbohydratesTotalG;
  @override
  final double? fiberG;
  @override
  final double? sugarG;
  @override
  final String? quality;

  @override
  String toString() {
    return 'FoodNutrition(name: $name, calories: $calories, servingSizeG: $servingSizeG, fatTotalG: $fatTotalG, fatSaturatedG: $fatSaturatedG, proteinG: $proteinG, sodiumMg: $sodiumMg, potassiumMg: $potassiumMg, cholesterolMg: $cholesterolMg, carbohydratesTotalG: $carbohydratesTotalG, fiberG: $fiberG, sugarG: $sugarG, quality: $quality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodNutritionImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.servingSizeG, servingSizeG) ||
                other.servingSizeG == servingSizeG) &&
            (identical(other.fatTotalG, fatTotalG) ||
                other.fatTotalG == fatTotalG) &&
            (identical(other.fatSaturatedG, fatSaturatedG) ||
                other.fatSaturatedG == fatSaturatedG) &&
            (identical(other.proteinG, proteinG) ||
                other.proteinG == proteinG) &&
            (identical(other.sodiumMg, sodiumMg) ||
                other.sodiumMg == sodiumMg) &&
            (identical(other.potassiumMg, potassiumMg) ||
                other.potassiumMg == potassiumMg) &&
            (identical(other.cholesterolMg, cholesterolMg) ||
                other.cholesterolMg == cholesterolMg) &&
            (identical(other.carbohydratesTotalG, carbohydratesTotalG) ||
                other.carbohydratesTotalG == carbohydratesTotalG) &&
            (identical(other.fiberG, fiberG) || other.fiberG == fiberG) &&
            (identical(other.sugarG, sugarG) || other.sugarG == sugarG) &&
            (identical(other.quality, quality) || other.quality == quality));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      calories,
      servingSizeG,
      fatTotalG,
      fatSaturatedG,
      proteinG,
      sodiumMg,
      potassiumMg,
      cholesterolMg,
      carbohydratesTotalG,
      fiberG,
      sugarG,
      quality);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodNutritionImplCopyWith<_$FoodNutritionImpl> get copyWith =>
      __$$FoodNutritionImplCopyWithImpl<_$FoodNutritionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodNutritionImplToJson(
      this,
    );
  }
}

abstract class _FoodNutrition implements FoodNutrition {
  const factory _FoodNutrition(
      {final String? name,
      final String? calories,
      @JsonKey(name: 'serving_size_g') final double? servingSizeG,
      @JsonKey(name: 'fat_total_g') final double? fatTotalG,
      @JsonKey(name: 'fat_saturated_g') final double? fatSaturatedG,
      final double? proteinG,
      final int? sodiumMg,
      final int? potassiumMg,
      final int? cholesterolMg,
      @JsonKey(name: 'carbohydrates_total_g') final double? carbohydratesTotalG,
      final double? fiberG,
      final double? sugarG,
      final String? quality}) = _$FoodNutritionImpl;

  factory _FoodNutrition.fromJson(Map<String, dynamic> json) =
      _$FoodNutritionImpl.fromJson;

  @override
  String? get name;
  @override
  String? get calories;
  @override
  @JsonKey(name: 'serving_size_g')
  double? get servingSizeG;
  @override
  @JsonKey(name: 'fat_total_g')
  double? get fatTotalG;
  @override
  @JsonKey(name: 'fat_saturated_g')
  double? get fatSaturatedG;
  @override
  double? get proteinG;
  @override
  int? get sodiumMg;
  @override
  int? get potassiumMg;
  @override
  int? get cholesterolMg;
  @override
  @JsonKey(name: 'carbohydrates_total_g')
  double? get carbohydratesTotalG;
  @override
  double? get fiberG;
  @override
  double? get sugarG;
  @override
  String? get quality;
  @override
  @JsonKey(ignore: true)
  _$$FoodNutritionImplCopyWith<_$FoodNutritionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
