// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'water_target_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WaterTargetItem _$WaterTargetItemFromJson(Map<String, dynamic> json) {
  return _WaterTargetItem.fromJson(json);
}

/// @nodoc
mixin _$WaterTargetItem {
  String get id => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  int get target => throw _privateConstructorUsedError;
  bool get isNotify => throw _privateConstructorUsedError;
  Target? get waterTarget => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WaterTargetItemCopyWith<WaterTargetItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaterTargetItemCopyWith<$Res> {
  factory $WaterTargetItemCopyWith(
          WaterTargetItem value, $Res Function(WaterTargetItem) then) =
      _$WaterTargetItemCopyWithImpl<$Res, WaterTargetItem>;
  @useResult
  $Res call(
      {String id,
      DateTime time,
      int target,
      bool isNotify,
      Target? waterTarget});

  $TargetCopyWith<$Res>? get waterTarget;
}

/// @nodoc
class _$WaterTargetItemCopyWithImpl<$Res, $Val extends WaterTargetItem>
    implements $WaterTargetItemCopyWith<$Res> {
  _$WaterTargetItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? time = null,
    Object? target = null,
    Object? isNotify = null,
    Object? waterTarget = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as int,
      isNotify: null == isNotify
          ? _value.isNotify
          : isNotify // ignore: cast_nullable_to_non_nullable
              as bool,
      waterTarget: freezed == waterTarget
          ? _value.waterTarget
          : waterTarget // ignore: cast_nullable_to_non_nullable
              as Target?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TargetCopyWith<$Res>? get waterTarget {
    if (_value.waterTarget == null) {
      return null;
    }

    return $TargetCopyWith<$Res>(_value.waterTarget!, (value) {
      return _then(_value.copyWith(waterTarget: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WaterTargetItemImplCopyWith<$Res>
    implements $WaterTargetItemCopyWith<$Res> {
  factory _$$WaterTargetItemImplCopyWith(_$WaterTargetItemImpl value,
          $Res Function(_$WaterTargetItemImpl) then) =
      __$$WaterTargetItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime time,
      int target,
      bool isNotify,
      Target? waterTarget});

  @override
  $TargetCopyWith<$Res>? get waterTarget;
}

/// @nodoc
class __$$WaterTargetItemImplCopyWithImpl<$Res>
    extends _$WaterTargetItemCopyWithImpl<$Res, _$WaterTargetItemImpl>
    implements _$$WaterTargetItemImplCopyWith<$Res> {
  __$$WaterTargetItemImplCopyWithImpl(
      _$WaterTargetItemImpl _value, $Res Function(_$WaterTargetItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? time = null,
    Object? target = null,
    Object? isNotify = null,
    Object? waterTarget = freezed,
  }) {
    return _then(_$WaterTargetItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as int,
      isNotify: null == isNotify
          ? _value.isNotify
          : isNotify // ignore: cast_nullable_to_non_nullable
              as bool,
      waterTarget: freezed == waterTarget
          ? _value.waterTarget
          : waterTarget // ignore: cast_nullable_to_non_nullable
              as Target?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WaterTargetItemImpl implements _WaterTargetItem {
  const _$WaterTargetItemImpl(
      {required this.id,
      required this.time,
      required this.target,
      required this.isNotify,
      this.waterTarget = null});

  factory _$WaterTargetItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$WaterTargetItemImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime time;
  @override
  final int target;
  @override
  final bool isNotify;
  @override
  @JsonKey()
  final Target? waterTarget;

  @override
  String toString() {
    return 'WaterTargetItem(id: $id, time: $time, target: $target, isNotify: $isNotify, waterTarget: $waterTarget)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaterTargetItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.isNotify, isNotify) ||
                other.isNotify == isNotify) &&
            (identical(other.waterTarget, waterTarget) ||
                other.waterTarget == waterTarget));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, time, target, isNotify, waterTarget);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WaterTargetItemImplCopyWith<_$WaterTargetItemImpl> get copyWith =>
      __$$WaterTargetItemImplCopyWithImpl<_$WaterTargetItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WaterTargetItemImplToJson(
      this,
    );
  }
}

abstract class _WaterTargetItem implements WaterTargetItem {
  const factory _WaterTargetItem(
      {required final String id,
      required final DateTime time,
      required final int target,
      required final bool isNotify,
      final Target? waterTarget}) = _$WaterTargetItemImpl;

  factory _WaterTargetItem.fromJson(Map<String, dynamic> json) =
      _$WaterTargetItemImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get time;
  @override
  int get target;
  @override
  bool get isNotify;
  @override
  Target? get waterTarget;
  @override
  @JsonKey(ignore: true)
  _$$WaterTargetItemImplCopyWith<_$WaterTargetItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
