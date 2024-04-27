// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_detect.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FoodDetect _$FoodDetectFromJson(Map<String, dynamic> json) {
  return _FoodDetect.fromJson(json);
}

/// @nodoc
mixin _$FoodDetect {
  @JsonKey(name: 'analysis_id')
  String get AnalysisId => throw _privateConstructorUsedError;
  List<Item> get items => throw _privateConstructorUsedError;
  List<String> get scopes => throw _privateConstructorUsedError;
  @JsonKey(name: 'nutritionalFacts')
  NutritionalFacts? get nutritionalFacts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodDetectCopyWith<FoodDetect> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodDetectCopyWith<$Res> {
  factory $FoodDetectCopyWith(
          FoodDetect value, $Res Function(FoodDetect) then) =
      _$FoodDetectCopyWithImpl<$Res, FoodDetect>;
  @useResult
  $Res call(
      {@JsonKey(name: 'analysis_id') String AnalysisId,
      List<Item> items,
      List<String> scopes,
      @JsonKey(name: 'nutritionalFacts') NutritionalFacts? nutritionalFacts});

  $NutritionalFactsCopyWith<$Res>? get nutritionalFacts;
}

/// @nodoc
class _$FoodDetectCopyWithImpl<$Res, $Val extends FoodDetect>
    implements $FoodDetectCopyWith<$Res> {
  _$FoodDetectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? AnalysisId = null,
    Object? items = null,
    Object? scopes = null,
    Object? nutritionalFacts = freezed,
  }) {
    return _then(_value.copyWith(
      AnalysisId: null == AnalysisId
          ? _value.AnalysisId
          : AnalysisId // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
      scopes: null == scopes
          ? _value.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nutritionalFacts: freezed == nutritionalFacts
          ? _value.nutritionalFacts
          : nutritionalFacts // ignore: cast_nullable_to_non_nullable
              as NutritionalFacts?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NutritionalFactsCopyWith<$Res>? get nutritionalFacts {
    if (_value.nutritionalFacts == null) {
      return null;
    }

    return $NutritionalFactsCopyWith<$Res>(_value.nutritionalFacts!, (value) {
      return _then(_value.copyWith(nutritionalFacts: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FoodDetectImplCopyWith<$Res>
    implements $FoodDetectCopyWith<$Res> {
  factory _$$FoodDetectImplCopyWith(
          _$FoodDetectImpl value, $Res Function(_$FoodDetectImpl) then) =
      __$$FoodDetectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'analysis_id') String AnalysisId,
      List<Item> items,
      List<String> scopes,
      @JsonKey(name: 'nutritionalFacts') NutritionalFacts? nutritionalFacts});

  @override
  $NutritionalFactsCopyWith<$Res>? get nutritionalFacts;
}

/// @nodoc
class __$$FoodDetectImplCopyWithImpl<$Res>
    extends _$FoodDetectCopyWithImpl<$Res, _$FoodDetectImpl>
    implements _$$FoodDetectImplCopyWith<$Res> {
  __$$FoodDetectImplCopyWithImpl(
      _$FoodDetectImpl _value, $Res Function(_$FoodDetectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? AnalysisId = null,
    Object? items = null,
    Object? scopes = null,
    Object? nutritionalFacts = freezed,
  }) {
    return _then(_$FoodDetectImpl(
      AnalysisId: null == AnalysisId
          ? _value.AnalysisId
          : AnalysisId // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
      scopes: null == scopes
          ? _value._scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nutritionalFacts: freezed == nutritionalFacts
          ? _value.nutritionalFacts
          : nutritionalFacts // ignore: cast_nullable_to_non_nullable
              as NutritionalFacts?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodDetectImpl implements _FoodDetect {
  _$FoodDetectImpl(
      {@JsonKey(name: 'analysis_id') required this.AnalysisId,
      required final List<Item> items,
      required final List<String> scopes,
      @JsonKey(name: 'nutritionalFacts') this.nutritionalFacts})
      : _items = items,
        _scopes = scopes;

  factory _$FoodDetectImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodDetectImplFromJson(json);

  @override
  @JsonKey(name: 'analysis_id')
  final String AnalysisId;
  final List<Item> _items;
  @override
  List<Item> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final List<String> _scopes;
  @override
  List<String> get scopes {
    if (_scopes is EqualUnmodifiableListView) return _scopes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scopes);
  }

  @override
  @JsonKey(name: 'nutritionalFacts')
  final NutritionalFacts? nutritionalFacts;

  @override
  String toString() {
    return 'FoodDetect(AnalysisId: $AnalysisId, items: $items, scopes: $scopes, nutritionalFacts: $nutritionalFacts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodDetectImpl &&
            (identical(other.AnalysisId, AnalysisId) ||
                other.AnalysisId == AnalysisId) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(other._scopes, _scopes) &&
            (identical(other.nutritionalFacts, nutritionalFacts) ||
                other.nutritionalFacts == nutritionalFacts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      AnalysisId,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_scopes),
      nutritionalFacts);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodDetectImplCopyWith<_$FoodDetectImpl> get copyWith =>
      __$$FoodDetectImplCopyWithImpl<_$FoodDetectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodDetectImplToJson(
      this,
    );
  }
}

abstract class _FoodDetect implements FoodDetect {
  factory _FoodDetect(
      {@JsonKey(name: 'analysis_id') required final String AnalysisId,
      required final List<Item> items,
      required final List<String> scopes,
      @JsonKey(name: 'nutritionalFacts')
      final NutritionalFacts? nutritionalFacts}) = _$FoodDetectImpl;

  factory _FoodDetect.fromJson(Map<String, dynamic> json) =
      _$FoodDetectImpl.fromJson;

  @override
  @JsonKey(name: 'analysis_id')
  String get AnalysisId;
  @override
  List<Item> get items;
  @override
  List<String> get scopes;
  @override
  @JsonKey(name: 'nutritionalFacts')
  NutritionalFacts? get nutritionalFacts;
  @override
  @JsonKey(ignore: true)
  _$$FoodDetectImplCopyWith<_$FoodDetectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Item _$ItemFromJson(Map<String, dynamic> json) {
  return _Item.fromJson(json);
}

/// @nodoc
mixin _$Item {
  List<Food> get food => throw _privateConstructorUsedError;
  Position get position => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res, Item>;
  @useResult
  $Res call({List<Food> food, Position position, String? color});

  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class _$ItemCopyWithImpl<$Res, $Val extends Item>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? food = null,
    Object? position = null,
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
      food: null == food
          ? _value.food
          : food // ignore: cast_nullable_to_non_nullable
              as List<Food>,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PositionCopyWith<$Res> get position {
    return $PositionCopyWith<$Res>(_value.position, (value) {
      return _then(_value.copyWith(position: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ItemImplCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$ItemImplCopyWith(
          _$ItemImpl value, $Res Function(_$ItemImpl) then) =
      __$$ItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Food> food, Position position, String? color});

  @override
  $PositionCopyWith<$Res> get position;
}

/// @nodoc
class __$$ItemImplCopyWithImpl<$Res>
    extends _$ItemCopyWithImpl<$Res, _$ItemImpl>
    implements _$$ItemImplCopyWith<$Res> {
  __$$ItemImplCopyWithImpl(_$ItemImpl _value, $Res Function(_$ItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? food = null,
    Object? position = null,
    Object? color = freezed,
  }) {
    return _then(_$ItemImpl(
      food: null == food
          ? _value._food
          : food // ignore: cast_nullable_to_non_nullable
              as List<Food>,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemImpl implements _Item {
  _$ItemImpl(
      {required final List<Food> food, required this.position, this.color})
      : _food = food;

  factory _$ItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemImplFromJson(json);

  final List<Food> _food;
  @override
  List<Food> get food {
    if (_food is EqualUnmodifiableListView) return _food;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_food);
  }

  @override
  final Position position;
  @override
  final String? color;

  @override
  String toString() {
    return 'Item(food: $food, position: $position, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemImpl &&
            const DeepCollectionEquality().equals(other._food, _food) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_food), position, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      __$$ItemImplCopyWithImpl<_$ItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemImplToJson(
      this,
    );
  }
}

abstract class _Item implements Item {
  factory _Item(
      {required final List<Food> food,
      required final Position position,
      final String? color}) = _$ItemImpl;

  factory _Item.fromJson(Map<String, dynamic> json) = _$ItemImpl.fromJson;

  @override
  List<Food> get food;
  @override
  Position get position;
  @override
  String? get color;
  @override
  @JsonKey(ignore: true)
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Food _$FoodFromJson(Map<String, dynamic> json) {
  return _Food.fromJson(json);
}

/// @nodoc
mixin _$Food {
  double get confidence => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'food_info')
  FoodInfo get foodInfo => throw _privateConstructorUsedError;
  List<String> get ingredients => throw _privateConstructorUsedError;
  @JsonKey(name: 'nutritionalFacts')
  NutritionalFacts? get nutritionalFacts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodCopyWith<Food> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodCopyWith<$Res> {
  factory $FoodCopyWith(Food value, $Res Function(Food) then) =
      _$FoodCopyWithImpl<$Res, Food>;
  @useResult
  $Res call(
      {double confidence,
      double quantity,
      @JsonKey(name: 'food_info') FoodInfo foodInfo,
      List<String> ingredients,
      @JsonKey(name: 'nutritionalFacts') NutritionalFacts? nutritionalFacts});

  $FoodInfoCopyWith<$Res> get foodInfo;
  $NutritionalFactsCopyWith<$Res>? get nutritionalFacts;
}

/// @nodoc
class _$FoodCopyWithImpl<$Res, $Val extends Food>
    implements $FoodCopyWith<$Res> {
  _$FoodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confidence = null,
    Object? quantity = null,
    Object? foodInfo = null,
    Object? ingredients = null,
    Object? nutritionalFacts = freezed,
  }) {
    return _then(_value.copyWith(
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      foodInfo: null == foodInfo
          ? _value.foodInfo
          : foodInfo // ignore: cast_nullable_to_non_nullable
              as FoodInfo,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nutritionalFacts: freezed == nutritionalFacts
          ? _value.nutritionalFacts
          : nutritionalFacts // ignore: cast_nullable_to_non_nullable
              as NutritionalFacts?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FoodInfoCopyWith<$Res> get foodInfo {
    return $FoodInfoCopyWith<$Res>(_value.foodInfo, (value) {
      return _then(_value.copyWith(foodInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NutritionalFactsCopyWith<$Res>? get nutritionalFacts {
    if (_value.nutritionalFacts == null) {
      return null;
    }

    return $NutritionalFactsCopyWith<$Res>(_value.nutritionalFacts!, (value) {
      return _then(_value.copyWith(nutritionalFacts: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FoodImplCopyWith<$Res> implements $FoodCopyWith<$Res> {
  factory _$$FoodImplCopyWith(
          _$FoodImpl value, $Res Function(_$FoodImpl) then) =
      __$$FoodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double confidence,
      double quantity,
      @JsonKey(name: 'food_info') FoodInfo foodInfo,
      List<String> ingredients,
      @JsonKey(name: 'nutritionalFacts') NutritionalFacts? nutritionalFacts});

  @override
  $FoodInfoCopyWith<$Res> get foodInfo;
  @override
  $NutritionalFactsCopyWith<$Res>? get nutritionalFacts;
}

/// @nodoc
class __$$FoodImplCopyWithImpl<$Res>
    extends _$FoodCopyWithImpl<$Res, _$FoodImpl>
    implements _$$FoodImplCopyWith<$Res> {
  __$$FoodImplCopyWithImpl(_$FoodImpl _value, $Res Function(_$FoodImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confidence = null,
    Object? quantity = null,
    Object? foodInfo = null,
    Object? ingredients = null,
    Object? nutritionalFacts = freezed,
  }) {
    return _then(_$FoodImpl(
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      foodInfo: null == foodInfo
          ? _value.foodInfo
          : foodInfo // ignore: cast_nullable_to_non_nullable
              as FoodInfo,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nutritionalFacts: freezed == nutritionalFacts
          ? _value.nutritionalFacts
          : nutritionalFacts // ignore: cast_nullable_to_non_nullable
              as NutritionalFacts?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodImpl implements _Food {
  _$FoodImpl(
      {required this.confidence,
      required this.quantity,
      @JsonKey(name: 'food_info') required this.foodInfo,
      required final List<String> ingredients,
      @JsonKey(name: 'nutritionalFacts') this.nutritionalFacts})
      : _ingredients = ingredients;

  factory _$FoodImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodImplFromJson(json);

  @override
  final double confidence;
  @override
  final double quantity;
  @override
  @JsonKey(name: 'food_info')
  final FoodInfo foodInfo;
  final List<String> _ingredients;
  @override
  List<String> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  @override
  @JsonKey(name: 'nutritionalFacts')
  final NutritionalFacts? nutritionalFacts;

  @override
  String toString() {
    return 'Food(confidence: $confidence, quantity: $quantity, foodInfo: $foodInfo, ingredients: $ingredients, nutritionalFacts: $nutritionalFacts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodImpl &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.foodInfo, foodInfo) ||
                other.foodInfo == foodInfo) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            (identical(other.nutritionalFacts, nutritionalFacts) ||
                other.nutritionalFacts == nutritionalFacts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, confidence, quantity, foodInfo,
      const DeepCollectionEquality().hash(_ingredients), nutritionalFacts);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodImplCopyWith<_$FoodImpl> get copyWith =>
      __$$FoodImplCopyWithImpl<_$FoodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodImplToJson(
      this,
    );
  }
}

abstract class _Food implements Food {
  factory _Food(
      {required final double confidence,
      required final double quantity,
      @JsonKey(name: 'food_info') required final FoodInfo foodInfo,
      required final List<String> ingredients,
      @JsonKey(name: 'nutritionalFacts')
      final NutritionalFacts? nutritionalFacts}) = _$FoodImpl;

  factory _Food.fromJson(Map<String, dynamic> json) = _$FoodImpl.fromJson;

  @override
  double get confidence;
  @override
  double get quantity;
  @override
  @JsonKey(name: 'food_info')
  FoodInfo get foodInfo;
  @override
  List<String> get ingredients;
  @override
  @JsonKey(name: 'nutritionalFacts')
  NutritionalFacts? get nutritionalFacts;
  @override
  @JsonKey(ignore: true)
  _$$FoodImplCopyWith<_$FoodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FoodInfo _$FoodInfoFromJson(Map<String, dynamic> json) {
  return _FoodInfo.fromJson(json);
}

/// @nodoc
mixin _$FoodInfo {
  @JsonKey(name: 'food_id')
  String get foodId => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: 'g_per_serving')
  double get gPerServing => throw _privateConstructorUsedError;
  @JsonKey(name: 'fv_grade')
  String get fvGrade => throw _privateConstructorUsedError;
  Nutrition? get nutrition => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FoodInfoCopyWith<FoodInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodInfoCopyWith<$Res> {
  factory $FoodInfoCopyWith(FoodInfo value, $Res Function(FoodInfo) then) =
      _$FoodInfoCopyWithImpl<$Res, FoodInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'food_id') String foodId,
      @JsonKey(name: 'display_name') String displayName,
      @JsonKey(name: 'g_per_serving') double gPerServing,
      @JsonKey(name: 'fv_grade') String fvGrade,
      Nutrition? nutrition});

  $NutritionCopyWith<$Res>? get nutrition;
}

/// @nodoc
class _$FoodInfoCopyWithImpl<$Res, $Val extends FoodInfo>
    implements $FoodInfoCopyWith<$Res> {
  _$FoodInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodId = null,
    Object? displayName = null,
    Object? gPerServing = null,
    Object? fvGrade = null,
    Object? nutrition = freezed,
  }) {
    return _then(_value.copyWith(
      foodId: null == foodId
          ? _value.foodId
          : foodId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      gPerServing: null == gPerServing
          ? _value.gPerServing
          : gPerServing // ignore: cast_nullable_to_non_nullable
              as double,
      fvGrade: null == fvGrade
          ? _value.fvGrade
          : fvGrade // ignore: cast_nullable_to_non_nullable
              as String,
      nutrition: freezed == nutrition
          ? _value.nutrition
          : nutrition // ignore: cast_nullable_to_non_nullable
              as Nutrition?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NutritionCopyWith<$Res>? get nutrition {
    if (_value.nutrition == null) {
      return null;
    }

    return $NutritionCopyWith<$Res>(_value.nutrition!, (value) {
      return _then(_value.copyWith(nutrition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FoodInfoImplCopyWith<$Res>
    implements $FoodInfoCopyWith<$Res> {
  factory _$$FoodInfoImplCopyWith(
          _$FoodInfoImpl value, $Res Function(_$FoodInfoImpl) then) =
      __$$FoodInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'food_id') String foodId,
      @JsonKey(name: 'display_name') String displayName,
      @JsonKey(name: 'g_per_serving') double gPerServing,
      @JsonKey(name: 'fv_grade') String fvGrade,
      Nutrition? nutrition});

  @override
  $NutritionCopyWith<$Res>? get nutrition;
}

/// @nodoc
class __$$FoodInfoImplCopyWithImpl<$Res>
    extends _$FoodInfoCopyWithImpl<$Res, _$FoodInfoImpl>
    implements _$$FoodInfoImplCopyWith<$Res> {
  __$$FoodInfoImplCopyWithImpl(
      _$FoodInfoImpl _value, $Res Function(_$FoodInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodId = null,
    Object? displayName = null,
    Object? gPerServing = null,
    Object? fvGrade = null,
    Object? nutrition = freezed,
  }) {
    return _then(_$FoodInfoImpl(
      foodId: null == foodId
          ? _value.foodId
          : foodId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      gPerServing: null == gPerServing
          ? _value.gPerServing
          : gPerServing // ignore: cast_nullable_to_non_nullable
              as double,
      fvGrade: null == fvGrade
          ? _value.fvGrade
          : fvGrade // ignore: cast_nullable_to_non_nullable
              as String,
      nutrition: freezed == nutrition
          ? _value.nutrition
          : nutrition // ignore: cast_nullable_to_non_nullable
              as Nutrition?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodInfoImpl implements _FoodInfo {
  _$FoodInfoImpl(
      {@JsonKey(name: 'food_id') required this.foodId,
      @JsonKey(name: 'display_name') required this.displayName,
      @JsonKey(name: 'g_per_serving') required this.gPerServing,
      @JsonKey(name: 'fv_grade') required this.fvGrade,
      this.nutrition});

  factory _$FoodInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodInfoImplFromJson(json);

  @override
  @JsonKey(name: 'food_id')
  final String foodId;
  @override
  @JsonKey(name: 'display_name')
  final String displayName;
  @override
  @JsonKey(name: 'g_per_serving')
  final double gPerServing;
  @override
  @JsonKey(name: 'fv_grade')
  final String fvGrade;
  @override
  final Nutrition? nutrition;

  @override
  String toString() {
    return 'FoodInfo(foodId: $foodId, displayName: $displayName, gPerServing: $gPerServing, fvGrade: $fvGrade, nutrition: $nutrition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodInfoImpl &&
            (identical(other.foodId, foodId) || other.foodId == foodId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.gPerServing, gPerServing) ||
                other.gPerServing == gPerServing) &&
            (identical(other.fvGrade, fvGrade) || other.fvGrade == fvGrade) &&
            (identical(other.nutrition, nutrition) ||
                other.nutrition == nutrition));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, foodId, displayName, gPerServing, fvGrade, nutrition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodInfoImplCopyWith<_$FoodInfoImpl> get copyWith =>
      __$$FoodInfoImplCopyWithImpl<_$FoodInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodInfoImplToJson(
      this,
    );
  }
}

abstract class _FoodInfo implements FoodInfo {
  factory _FoodInfo(
      {@JsonKey(name: 'food_id') required final String foodId,
      @JsonKey(name: 'display_name') required final String displayName,
      @JsonKey(name: 'g_per_serving') required final double gPerServing,
      @JsonKey(name: 'fv_grade') required final String fvGrade,
      final Nutrition? nutrition}) = _$FoodInfoImpl;

  factory _FoodInfo.fromJson(Map<String, dynamic> json) =
      _$FoodInfoImpl.fromJson;

  @override
  @JsonKey(name: 'food_id')
  String get foodId;
  @override
  @JsonKey(name: 'display_name')
  String get displayName;
  @override
  @JsonKey(name: 'g_per_serving')
  double get gPerServing;
  @override
  @JsonKey(name: 'fv_grade')
  String get fvGrade;
  @override
  Nutrition? get nutrition;
  @override
  @JsonKey(ignore: true)
  _$$FoodInfoImplCopyWith<_$FoodInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Nutrition _$NutritionFromJson(Map<String, dynamic> json) {
  return _Nutrition.fromJson(json);
}

/// @nodoc
mixin _$Nutrition {
  double? get alcohol100g => throw _privateConstructorUsedError;
  double? get calcium100g => throw _privateConstructorUsedError;
  double? get calories100g => throw _privateConstructorUsedError;
  double? get carbs100g => throw _privateConstructorUsedError;
  double? get chloride100g => throw _privateConstructorUsedError;
  double? get cholesterol100g => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NutritionCopyWith<Nutrition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionCopyWith<$Res> {
  factory $NutritionCopyWith(Nutrition value, $Res Function(Nutrition) then) =
      _$NutritionCopyWithImpl<$Res, Nutrition>;
  @useResult
  $Res call(
      {double? alcohol100g,
      double? calcium100g,
      double? calories100g,
      double? carbs100g,
      double? chloride100g,
      double? cholesterol100g});
}

/// @nodoc
class _$NutritionCopyWithImpl<$Res, $Val extends Nutrition>
    implements $NutritionCopyWith<$Res> {
  _$NutritionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alcohol100g = freezed,
    Object? calcium100g = freezed,
    Object? calories100g = freezed,
    Object? carbs100g = freezed,
    Object? chloride100g = freezed,
    Object? cholesterol100g = freezed,
  }) {
    return _then(_value.copyWith(
      alcohol100g: freezed == alcohol100g
          ? _value.alcohol100g
          : alcohol100g // ignore: cast_nullable_to_non_nullable
              as double?,
      calcium100g: freezed == calcium100g
          ? _value.calcium100g
          : calcium100g // ignore: cast_nullable_to_non_nullable
              as double?,
      calories100g: freezed == calories100g
          ? _value.calories100g
          : calories100g // ignore: cast_nullable_to_non_nullable
              as double?,
      carbs100g: freezed == carbs100g
          ? _value.carbs100g
          : carbs100g // ignore: cast_nullable_to_non_nullable
              as double?,
      chloride100g: freezed == chloride100g
          ? _value.chloride100g
          : chloride100g // ignore: cast_nullable_to_non_nullable
              as double?,
      cholesterol100g: freezed == cholesterol100g
          ? _value.cholesterol100g
          : cholesterol100g // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutritionImplCopyWith<$Res>
    implements $NutritionCopyWith<$Res> {
  factory _$$NutritionImplCopyWith(
          _$NutritionImpl value, $Res Function(_$NutritionImpl) then) =
      __$$NutritionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? alcohol100g,
      double? calcium100g,
      double? calories100g,
      double? carbs100g,
      double? chloride100g,
      double? cholesterol100g});
}

/// @nodoc
class __$$NutritionImplCopyWithImpl<$Res>
    extends _$NutritionCopyWithImpl<$Res, _$NutritionImpl>
    implements _$$NutritionImplCopyWith<$Res> {
  __$$NutritionImplCopyWithImpl(
      _$NutritionImpl _value, $Res Function(_$NutritionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alcohol100g = freezed,
    Object? calcium100g = freezed,
    Object? calories100g = freezed,
    Object? carbs100g = freezed,
    Object? chloride100g = freezed,
    Object? cholesterol100g = freezed,
  }) {
    return _then(_$NutritionImpl(
      alcohol100g: freezed == alcohol100g
          ? _value.alcohol100g
          : alcohol100g // ignore: cast_nullable_to_non_nullable
              as double?,
      calcium100g: freezed == calcium100g
          ? _value.calcium100g
          : calcium100g // ignore: cast_nullable_to_non_nullable
              as double?,
      calories100g: freezed == calories100g
          ? _value.calories100g
          : calories100g // ignore: cast_nullable_to_non_nullable
              as double?,
      carbs100g: freezed == carbs100g
          ? _value.carbs100g
          : carbs100g // ignore: cast_nullable_to_non_nullable
              as double?,
      chloride100g: freezed == chloride100g
          ? _value.chloride100g
          : chloride100g // ignore: cast_nullable_to_non_nullable
              as double?,
      cholesterol100g: freezed == cholesterol100g
          ? _value.cholesterol100g
          : cholesterol100g // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NutritionImpl implements _Nutrition {
  _$NutritionImpl(
      {this.alcohol100g,
      this.calcium100g,
      this.calories100g,
      this.carbs100g,
      this.chloride100g,
      this.cholesterol100g});

  factory _$NutritionImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutritionImplFromJson(json);

  @override
  final double? alcohol100g;
  @override
  final double? calcium100g;
  @override
  final double? calories100g;
  @override
  final double? carbs100g;
  @override
  final double? chloride100g;
  @override
  final double? cholesterol100g;

  @override
  String toString() {
    return 'Nutrition(alcohol100g: $alcohol100g, calcium100g: $calcium100g, calories100g: $calories100g, carbs100g: $carbs100g, chloride100g: $chloride100g, cholesterol100g: $cholesterol100g)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionImpl &&
            (identical(other.alcohol100g, alcohol100g) ||
                other.alcohol100g == alcohol100g) &&
            (identical(other.calcium100g, calcium100g) ||
                other.calcium100g == calcium100g) &&
            (identical(other.calories100g, calories100g) ||
                other.calories100g == calories100g) &&
            (identical(other.carbs100g, carbs100g) ||
                other.carbs100g == carbs100g) &&
            (identical(other.chloride100g, chloride100g) ||
                other.chloride100g == chloride100g) &&
            (identical(other.cholesterol100g, cholesterol100g) ||
                other.cholesterol100g == cholesterol100g));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, alcohol100g, calcium100g,
      calories100g, carbs100g, chloride100g, cholesterol100g);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionImplCopyWith<_$NutritionImpl> get copyWith =>
      __$$NutritionImplCopyWithImpl<_$NutritionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NutritionImplToJson(
      this,
    );
  }
}

abstract class _Nutrition implements Nutrition {
  factory _Nutrition(
      {final double? alcohol100g,
      final double? calcium100g,
      final double? calories100g,
      final double? carbs100g,
      final double? chloride100g,
      final double? cholesterol100g}) = _$NutritionImpl;

  factory _Nutrition.fromJson(Map<String, dynamic> json) =
      _$NutritionImpl.fromJson;

  @override
  double? get alcohol100g;
  @override
  double? get calcium100g;
  @override
  double? get calories100g;
  @override
  double? get carbs100g;
  @override
  double? get chloride100g;
  @override
  double? get cholesterol100g;
  @override
  @JsonKey(ignore: true)
  _$$NutritionImplCopyWith<_$NutritionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NutritionalFacts _$NutritionalFactsFromJson(Map<String, dynamic> json) {
  return _NutritionalFacts.fromJson(json);
}

/// @nodoc
mixin _$NutritionalFacts {
  double get calories => throw _privateConstructorUsedError;
  double get fat => throw _privateConstructorUsedError;
  double get proteins => throw _privateConstructorUsedError;
  double get carbs => throw _privateConstructorUsedError;
  double get fibers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NutritionalFactsCopyWith<NutritionalFacts> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionalFactsCopyWith<$Res> {
  factory $NutritionalFactsCopyWith(
          NutritionalFacts value, $Res Function(NutritionalFacts) then) =
      _$NutritionalFactsCopyWithImpl<$Res, NutritionalFacts>;
  @useResult
  $Res call(
      {double calories,
      double fat,
      double proteins,
      double carbs,
      double fibers});
}

/// @nodoc
class _$NutritionalFactsCopyWithImpl<$Res, $Val extends NutritionalFacts>
    implements $NutritionalFactsCopyWith<$Res> {
  _$NutritionalFactsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calories = null,
    Object? fat = null,
    Object? proteins = null,
    Object? carbs = null,
    Object? fibers = null,
  }) {
    return _then(_value.copyWith(
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      proteins: null == proteins
          ? _value.proteins
          : proteins // ignore: cast_nullable_to_non_nullable
              as double,
      carbs: null == carbs
          ? _value.carbs
          : carbs // ignore: cast_nullable_to_non_nullable
              as double,
      fibers: null == fibers
          ? _value.fibers
          : fibers // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NutritionalFactsImplCopyWith<$Res>
    implements $NutritionalFactsCopyWith<$Res> {
  factory _$$NutritionalFactsImplCopyWith(_$NutritionalFactsImpl value,
          $Res Function(_$NutritionalFactsImpl) then) =
      __$$NutritionalFactsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double calories,
      double fat,
      double proteins,
      double carbs,
      double fibers});
}

/// @nodoc
class __$$NutritionalFactsImplCopyWithImpl<$Res>
    extends _$NutritionalFactsCopyWithImpl<$Res, _$NutritionalFactsImpl>
    implements _$$NutritionalFactsImplCopyWith<$Res> {
  __$$NutritionalFactsImplCopyWithImpl(_$NutritionalFactsImpl _value,
      $Res Function(_$NutritionalFactsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calories = null,
    Object? fat = null,
    Object? proteins = null,
    Object? carbs = null,
    Object? fibers = null,
  }) {
    return _then(_$NutritionalFactsImpl(
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      proteins: null == proteins
          ? _value.proteins
          : proteins // ignore: cast_nullable_to_non_nullable
              as double,
      carbs: null == carbs
          ? _value.carbs
          : carbs // ignore: cast_nullable_to_non_nullable
              as double,
      fibers: null == fibers
          ? _value.fibers
          : fibers // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NutritionalFactsImpl implements _NutritionalFacts {
  _$NutritionalFactsImpl(
      {required this.calories,
      required this.fat,
      required this.proteins,
      required this.carbs,
      required this.fibers});

  factory _$NutritionalFactsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutritionalFactsImplFromJson(json);

  @override
  final double calories;
  @override
  final double fat;
  @override
  final double proteins;
  @override
  final double carbs;
  @override
  final double fibers;

  @override
  String toString() {
    return 'NutritionalFacts(calories: $calories, fat: $fat, proteins: $proteins, carbs: $carbs, fibers: $fibers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionalFactsImpl &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.fat, fat) || other.fat == fat) &&
            (identical(other.proteins, proteins) ||
                other.proteins == proteins) &&
            (identical(other.carbs, carbs) || other.carbs == carbs) &&
            (identical(other.fibers, fibers) || other.fibers == fibers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, calories, fat, proteins, carbs, fibers);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionalFactsImplCopyWith<_$NutritionalFactsImpl> get copyWith =>
      __$$NutritionalFactsImplCopyWithImpl<_$NutritionalFactsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NutritionalFactsImplToJson(
      this,
    );
  }
}

abstract class _NutritionalFacts implements NutritionalFacts {
  factory _NutritionalFacts(
      {required final double calories,
      required final double fat,
      required final double proteins,
      required final double carbs,
      required final double fibers}) = _$NutritionalFactsImpl;

  factory _NutritionalFacts.fromJson(Map<String, dynamic> json) =
      _$NutritionalFactsImpl.fromJson;

  @override
  double get calories;
  @override
  double get fat;
  @override
  double get proteins;
  @override
  double get carbs;
  @override
  double get fibers;
  @override
  @JsonKey(ignore: true)
  _$$NutritionalFactsImplCopyWith<_$NutritionalFactsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Position _$PositionFromJson(Map<String, dynamic> json) {
  return _Position.fromJson(json);
}

/// @nodoc
mixin _$Position {
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PositionCopyWith<Position> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PositionCopyWith<$Res> {
  factory $PositionCopyWith(Position value, $Res Function(Position) then) =
      _$PositionCopyWithImpl<$Res, Position>;
  @useResult
  $Res call({double x, double y, double width, double height});
}

/// @nodoc
class _$PositionCopyWithImpl<$Res, $Val extends Position>
    implements $PositionCopyWith<$Res> {
  _$PositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? width = null,
    Object? height = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PositionImplCopyWith<$Res>
    implements $PositionCopyWith<$Res> {
  factory _$$PositionImplCopyWith(
          _$PositionImpl value, $Res Function(_$PositionImpl) then) =
      __$$PositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double x, double y, double width, double height});
}

/// @nodoc
class __$$PositionImplCopyWithImpl<$Res>
    extends _$PositionCopyWithImpl<$Res, _$PositionImpl>
    implements _$$PositionImplCopyWith<$Res> {
  __$$PositionImplCopyWithImpl(
      _$PositionImpl _value, $Res Function(_$PositionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? width = null,
    Object? height = null,
  }) {
    return _then(_$PositionImpl(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PositionImpl implements _Position {
  _$PositionImpl(
      {required this.x,
      required this.y,
      required this.width,
      required this.height});

  factory _$PositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PositionImplFromJson(json);

  @override
  final double x;
  @override
  final double y;
  @override
  final double width;
  @override
  final double height;

  @override
  String toString() {
    return 'Position(x: $x, y: $y, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PositionImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, x, y, width, height);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PositionImplCopyWith<_$PositionImpl> get copyWith =>
      __$$PositionImplCopyWithImpl<_$PositionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PositionImplToJson(
      this,
    );
  }
}

abstract class _Position implements Position {
  factory _Position(
      {required final double x,
      required final double y,
      required final double width,
      required final double height}) = _$PositionImpl;

  factory _Position.fromJson(Map<String, dynamic> json) =
      _$PositionImpl.fromJson;

  @override
  double get x;
  @override
  double get y;
  @override
  double get width;
  @override
  double get height;
  @override
  @JsonKey(ignore: true)
  _$$PositionImplCopyWith<_$PositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
