// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dish.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Dish _$DishFromJson(Map<String, dynamic> json) {
  return _Dish.fromJson(json);
}

/// @nodoc
mixin _$Dish {
  int get RecipeId => throw _privateConstructorUsedError;
  String get Name => throw _privateConstructorUsedError;
  String get CookTime => throw _privateConstructorUsedError;
  String get PrepTime => throw _privateConstructorUsedError;
  String get TotalTime => throw _privateConstructorUsedError;
  List<String> get RecipeIngredientParts => throw _privateConstructorUsedError;
  double get Calories => throw _privateConstructorUsedError;
  double get FatContent => throw _privateConstructorUsedError;
  double get SaturatedFatContent => throw _privateConstructorUsedError;
  double get CholesterolContent => throw _privateConstructorUsedError;
  double get SodiumContent => throw _privateConstructorUsedError;
  double get CarbohydrateContent => throw _privateConstructorUsedError;
  double get FiberContent => throw _privateConstructorUsedError;
  double get SugarContent => throw _privateConstructorUsedError;
  double get ProteinContent => throw _privateConstructorUsedError;
  @JsonKey(name: "image_link")
  String get imageLink => throw _privateConstructorUsedError;
  List<String> get RecipeInstructions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DishCopyWith<Dish> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DishCopyWith<$Res> {
  factory $DishCopyWith(Dish value, $Res Function(Dish) then) =
      _$DishCopyWithImpl<$Res, Dish>;
  @useResult
  $Res call(
      {int RecipeId,
      String Name,
      String CookTime,
      String PrepTime,
      String TotalTime,
      List<String> RecipeIngredientParts,
      double Calories,
      double FatContent,
      double SaturatedFatContent,
      double CholesterolContent,
      double SodiumContent,
      double CarbohydrateContent,
      double FiberContent,
      double SugarContent,
      double ProteinContent,
      @JsonKey(name: "image_link") String imageLink,
      List<String> RecipeInstructions});
}

/// @nodoc
class _$DishCopyWithImpl<$Res, $Val extends Dish>
    implements $DishCopyWith<$Res> {
  _$DishCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? RecipeId = null,
    Object? Name = null,
    Object? CookTime = null,
    Object? PrepTime = null,
    Object? TotalTime = null,
    Object? RecipeIngredientParts = null,
    Object? Calories = null,
    Object? FatContent = null,
    Object? SaturatedFatContent = null,
    Object? CholesterolContent = null,
    Object? SodiumContent = null,
    Object? CarbohydrateContent = null,
    Object? FiberContent = null,
    Object? SugarContent = null,
    Object? ProteinContent = null,
    Object? imageLink = null,
    Object? RecipeInstructions = null,
  }) {
    return _then(_value.copyWith(
      RecipeId: null == RecipeId
          ? _value.RecipeId
          : RecipeId // ignore: cast_nullable_to_non_nullable
              as int,
      Name: null == Name
          ? _value.Name
          : Name // ignore: cast_nullable_to_non_nullable
              as String,
      CookTime: null == CookTime
          ? _value.CookTime
          : CookTime // ignore: cast_nullable_to_non_nullable
              as String,
      PrepTime: null == PrepTime
          ? _value.PrepTime
          : PrepTime // ignore: cast_nullable_to_non_nullable
              as String,
      TotalTime: null == TotalTime
          ? _value.TotalTime
          : TotalTime // ignore: cast_nullable_to_non_nullable
              as String,
      RecipeIngredientParts: null == RecipeIngredientParts
          ? _value.RecipeIngredientParts
          : RecipeIngredientParts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      Calories: null == Calories
          ? _value.Calories
          : Calories // ignore: cast_nullable_to_non_nullable
              as double,
      FatContent: null == FatContent
          ? _value.FatContent
          : FatContent // ignore: cast_nullable_to_non_nullable
              as double,
      SaturatedFatContent: null == SaturatedFatContent
          ? _value.SaturatedFatContent
          : SaturatedFatContent // ignore: cast_nullable_to_non_nullable
              as double,
      CholesterolContent: null == CholesterolContent
          ? _value.CholesterolContent
          : CholesterolContent // ignore: cast_nullable_to_non_nullable
              as double,
      SodiumContent: null == SodiumContent
          ? _value.SodiumContent
          : SodiumContent // ignore: cast_nullable_to_non_nullable
              as double,
      CarbohydrateContent: null == CarbohydrateContent
          ? _value.CarbohydrateContent
          : CarbohydrateContent // ignore: cast_nullable_to_non_nullable
              as double,
      FiberContent: null == FiberContent
          ? _value.FiberContent
          : FiberContent // ignore: cast_nullable_to_non_nullable
              as double,
      SugarContent: null == SugarContent
          ? _value.SugarContent
          : SugarContent // ignore: cast_nullable_to_non_nullable
              as double,
      ProteinContent: null == ProteinContent
          ? _value.ProteinContent
          : ProteinContent // ignore: cast_nullable_to_non_nullable
              as double,
      imageLink: null == imageLink
          ? _value.imageLink
          : imageLink // ignore: cast_nullable_to_non_nullable
              as String,
      RecipeInstructions: null == RecipeInstructions
          ? _value.RecipeInstructions
          : RecipeInstructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DishImplCopyWith<$Res> implements $DishCopyWith<$Res> {
  factory _$$DishImplCopyWith(
          _$DishImpl value, $Res Function(_$DishImpl) then) =
      __$$DishImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int RecipeId,
      String Name,
      String CookTime,
      String PrepTime,
      String TotalTime,
      List<String> RecipeIngredientParts,
      double Calories,
      double FatContent,
      double SaturatedFatContent,
      double CholesterolContent,
      double SodiumContent,
      double CarbohydrateContent,
      double FiberContent,
      double SugarContent,
      double ProteinContent,
      @JsonKey(name: "image_link") String imageLink,
      List<String> RecipeInstructions});
}

/// @nodoc
class __$$DishImplCopyWithImpl<$Res>
    extends _$DishCopyWithImpl<$Res, _$DishImpl>
    implements _$$DishImplCopyWith<$Res> {
  __$$DishImplCopyWithImpl(_$DishImpl _value, $Res Function(_$DishImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? RecipeId = null,
    Object? Name = null,
    Object? CookTime = null,
    Object? PrepTime = null,
    Object? TotalTime = null,
    Object? RecipeIngredientParts = null,
    Object? Calories = null,
    Object? FatContent = null,
    Object? SaturatedFatContent = null,
    Object? CholesterolContent = null,
    Object? SodiumContent = null,
    Object? CarbohydrateContent = null,
    Object? FiberContent = null,
    Object? SugarContent = null,
    Object? ProteinContent = null,
    Object? imageLink = null,
    Object? RecipeInstructions = null,
  }) {
    return _then(_$DishImpl(
      RecipeId: null == RecipeId
          ? _value.RecipeId
          : RecipeId // ignore: cast_nullable_to_non_nullable
              as int,
      Name: null == Name
          ? _value.Name
          : Name // ignore: cast_nullable_to_non_nullable
              as String,
      CookTime: null == CookTime
          ? _value.CookTime
          : CookTime // ignore: cast_nullable_to_non_nullable
              as String,
      PrepTime: null == PrepTime
          ? _value.PrepTime
          : PrepTime // ignore: cast_nullable_to_non_nullable
              as String,
      TotalTime: null == TotalTime
          ? _value.TotalTime
          : TotalTime // ignore: cast_nullable_to_non_nullable
              as String,
      RecipeIngredientParts: null == RecipeIngredientParts
          ? _value._RecipeIngredientParts
          : RecipeIngredientParts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      Calories: null == Calories
          ? _value.Calories
          : Calories // ignore: cast_nullable_to_non_nullable
              as double,
      FatContent: null == FatContent
          ? _value.FatContent
          : FatContent // ignore: cast_nullable_to_non_nullable
              as double,
      SaturatedFatContent: null == SaturatedFatContent
          ? _value.SaturatedFatContent
          : SaturatedFatContent // ignore: cast_nullable_to_non_nullable
              as double,
      CholesterolContent: null == CholesterolContent
          ? _value.CholesterolContent
          : CholesterolContent // ignore: cast_nullable_to_non_nullable
              as double,
      SodiumContent: null == SodiumContent
          ? _value.SodiumContent
          : SodiumContent // ignore: cast_nullable_to_non_nullable
              as double,
      CarbohydrateContent: null == CarbohydrateContent
          ? _value.CarbohydrateContent
          : CarbohydrateContent // ignore: cast_nullable_to_non_nullable
              as double,
      FiberContent: null == FiberContent
          ? _value.FiberContent
          : FiberContent // ignore: cast_nullable_to_non_nullable
              as double,
      SugarContent: null == SugarContent
          ? _value.SugarContent
          : SugarContent // ignore: cast_nullable_to_non_nullable
              as double,
      ProteinContent: null == ProteinContent
          ? _value.ProteinContent
          : ProteinContent // ignore: cast_nullable_to_non_nullable
              as double,
      imageLink: null == imageLink
          ? _value.imageLink
          : imageLink // ignore: cast_nullable_to_non_nullable
              as String,
      RecipeInstructions: null == RecipeInstructions
          ? _value._RecipeInstructions
          : RecipeInstructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DishImpl with DiagnosticableTreeMixin implements _Dish {
  const _$DishImpl(
      {this.RecipeId = 0,
      this.Name = "",
      this.CookTime = "",
      this.PrepTime = "",
      this.TotalTime = "",
      final List<String> RecipeIngredientParts = const [],
      this.Calories = 0,
      this.FatContent = 0,
      this.SaturatedFatContent = 0,
      this.CholesterolContent = 0,
      this.SodiumContent = 0,
      this.CarbohydrateContent = 0,
      this.FiberContent = 0,
      this.SugarContent = 0,
      this.ProteinContent = 0,
      @JsonKey(name: "image_link") this.imageLink = "",
      final List<String> RecipeInstructions = const []})
      : _RecipeIngredientParts = RecipeIngredientParts,
        _RecipeInstructions = RecipeInstructions;

  factory _$DishImpl.fromJson(Map<String, dynamic> json) =>
      _$$DishImplFromJson(json);

  @override
  @JsonKey()
  final int RecipeId;
  @override
  @JsonKey()
  final String Name;
  @override
  @JsonKey()
  final String CookTime;
  @override
  @JsonKey()
  final String PrepTime;
  @override
  @JsonKey()
  final String TotalTime;
  final List<String> _RecipeIngredientParts;
  @override
  @JsonKey()
  List<String> get RecipeIngredientParts {
    if (_RecipeIngredientParts is EqualUnmodifiableListView)
      return _RecipeIngredientParts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_RecipeIngredientParts);
  }

  @override
  @JsonKey()
  final double Calories;
  @override
  @JsonKey()
  final double FatContent;
  @override
  @JsonKey()
  final double SaturatedFatContent;
  @override
  @JsonKey()
  final double CholesterolContent;
  @override
  @JsonKey()
  final double SodiumContent;
  @override
  @JsonKey()
  final double CarbohydrateContent;
  @override
  @JsonKey()
  final double FiberContent;
  @override
  @JsonKey()
  final double SugarContent;
  @override
  @JsonKey()
  final double ProteinContent;
  @override
  @JsonKey(name: "image_link")
  final String imageLink;
  final List<String> _RecipeInstructions;
  @override
  @JsonKey()
  List<String> get RecipeInstructions {
    if (_RecipeInstructions is EqualUnmodifiableListView)
      return _RecipeInstructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_RecipeInstructions);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Dish(RecipeId: $RecipeId, Name: $Name, CookTime: $CookTime, PrepTime: $PrepTime, TotalTime: $TotalTime, RecipeIngredientParts: $RecipeIngredientParts, Calories: $Calories, FatContent: $FatContent, SaturatedFatContent: $SaturatedFatContent, CholesterolContent: $CholesterolContent, SodiumContent: $SodiumContent, CarbohydrateContent: $CarbohydrateContent, FiberContent: $FiberContent, SugarContent: $SugarContent, ProteinContent: $ProteinContent, imageLink: $imageLink, RecipeInstructions: $RecipeInstructions)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Dish'))
      ..add(DiagnosticsProperty('RecipeId', RecipeId))
      ..add(DiagnosticsProperty('Name', Name))
      ..add(DiagnosticsProperty('CookTime', CookTime))
      ..add(DiagnosticsProperty('PrepTime', PrepTime))
      ..add(DiagnosticsProperty('TotalTime', TotalTime))
      ..add(DiagnosticsProperty('RecipeIngredientParts', RecipeIngredientParts))
      ..add(DiagnosticsProperty('Calories', Calories))
      ..add(DiagnosticsProperty('FatContent', FatContent))
      ..add(DiagnosticsProperty('SaturatedFatContent', SaturatedFatContent))
      ..add(DiagnosticsProperty('CholesterolContent', CholesterolContent))
      ..add(DiagnosticsProperty('SodiumContent', SodiumContent))
      ..add(DiagnosticsProperty('CarbohydrateContent', CarbohydrateContent))
      ..add(DiagnosticsProperty('FiberContent', FiberContent))
      ..add(DiagnosticsProperty('SugarContent', SugarContent))
      ..add(DiagnosticsProperty('ProteinContent', ProteinContent))
      ..add(DiagnosticsProperty('imageLink', imageLink))
      ..add(DiagnosticsProperty('RecipeInstructions', RecipeInstructions));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DishImpl &&
            (identical(other.RecipeId, RecipeId) ||
                other.RecipeId == RecipeId) &&
            (identical(other.Name, Name) || other.Name == Name) &&
            (identical(other.CookTime, CookTime) ||
                other.CookTime == CookTime) &&
            (identical(other.PrepTime, PrepTime) ||
                other.PrepTime == PrepTime) &&
            (identical(other.TotalTime, TotalTime) ||
                other.TotalTime == TotalTime) &&
            const DeepCollectionEquality()
                .equals(other._RecipeIngredientParts, _RecipeIngredientParts) &&
            (identical(other.Calories, Calories) ||
                other.Calories == Calories) &&
            (identical(other.FatContent, FatContent) ||
                other.FatContent == FatContent) &&
            (identical(other.SaturatedFatContent, SaturatedFatContent) ||
                other.SaturatedFatContent == SaturatedFatContent) &&
            (identical(other.CholesterolContent, CholesterolContent) ||
                other.CholesterolContent == CholesterolContent) &&
            (identical(other.SodiumContent, SodiumContent) ||
                other.SodiumContent == SodiumContent) &&
            (identical(other.CarbohydrateContent, CarbohydrateContent) ||
                other.CarbohydrateContent == CarbohydrateContent) &&
            (identical(other.FiberContent, FiberContent) ||
                other.FiberContent == FiberContent) &&
            (identical(other.SugarContent, SugarContent) ||
                other.SugarContent == SugarContent) &&
            (identical(other.ProteinContent, ProteinContent) ||
                other.ProteinContent == ProteinContent) &&
            (identical(other.imageLink, imageLink) ||
                other.imageLink == imageLink) &&
            const DeepCollectionEquality()
                .equals(other._RecipeInstructions, _RecipeInstructions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      RecipeId,
      Name,
      CookTime,
      PrepTime,
      TotalTime,
      const DeepCollectionEquality().hash(_RecipeIngredientParts),
      Calories,
      FatContent,
      SaturatedFatContent,
      CholesterolContent,
      SodiumContent,
      CarbohydrateContent,
      FiberContent,
      SugarContent,
      ProteinContent,
      imageLink,
      const DeepCollectionEquality().hash(_RecipeInstructions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DishImplCopyWith<_$DishImpl> get copyWith =>
      __$$DishImplCopyWithImpl<_$DishImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DishImplToJson(
      this,
    );
  }
}

abstract class _Dish implements Dish {
  const factory _Dish(
      {final int RecipeId,
      final String Name,
      final String CookTime,
      final String PrepTime,
      final String TotalTime,
      final List<String> RecipeIngredientParts,
      final double Calories,
      final double FatContent,
      final double SaturatedFatContent,
      final double CholesterolContent,
      final double SodiumContent,
      final double CarbohydrateContent,
      final double FiberContent,
      final double SugarContent,
      final double ProteinContent,
      @JsonKey(name: "image_link") final String imageLink,
      final List<String> RecipeInstructions}) = _$DishImpl;

  factory _Dish.fromJson(Map<String, dynamic> json) = _$DishImpl.fromJson;

  @override
  int get RecipeId;
  @override
  String get Name;
  @override
  String get CookTime;
  @override
  String get PrepTime;
  @override
  String get TotalTime;
  @override
  List<String> get RecipeIngredientParts;
  @override
  double get Calories;
  @override
  double get FatContent;
  @override
  double get SaturatedFatContent;
  @override
  double get CholesterolContent;
  @override
  double get SodiumContent;
  @override
  double get CarbohydrateContent;
  @override
  double get FiberContent;
  @override
  double get SugarContent;
  @override
  double get ProteinContent;
  @override
  @JsonKey(name: "image_link")
  String get imageLink;
  @override
  List<String> get RecipeInstructions;
  @override
  @JsonKey(ignore: true)
  _$$DishImplCopyWith<_$DishImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
