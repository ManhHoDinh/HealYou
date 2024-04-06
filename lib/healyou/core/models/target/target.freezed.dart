// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'target.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Target _$TargetFromJson(Map<String, dynamic> json) {
  return _Target.fromJson(json);
}

/// @nodoc
mixin _$Target {
  String get id => throw _privateConstructorUsedError;
  TargetType get type => throw _privateConstructorUsedError;
  int get target => throw _privateConstructorUsedError;
  int get reached => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "time", fromJson: _sendAtFromJson)
  DateTime? get time => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TargetCopyWith<Target> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TargetCopyWith<$Res> {
  factory $TargetCopyWith(Target value, $Res Function(Target) then) =
      _$TargetCopyWithImpl<$Res, Target>;
  @useResult
  $Res call(
      {String id,
      TargetType type,
      int target,
      int reached,
      String userId,
      @JsonKey(name: "time", fromJson: _sendAtFromJson) DateTime? time});
}

/// @nodoc
class _$TargetCopyWithImpl<$Res, $Val extends Target>
    implements $TargetCopyWith<$Res> {
  _$TargetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? target = null,
    Object? reached = null,
    Object? userId = null,
    Object? time = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TargetType,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as int,
      reached: null == reached
          ? _value.reached
          : reached // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TargetImplCopyWith<$Res> implements $TargetCopyWith<$Res> {
  factory _$$TargetImplCopyWith(
          _$TargetImpl value, $Res Function(_$TargetImpl) then) =
      __$$TargetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      TargetType type,
      int target,
      int reached,
      String userId,
      @JsonKey(name: "time", fromJson: _sendAtFromJson) DateTime? time});
}

/// @nodoc
class __$$TargetImplCopyWithImpl<$Res>
    extends _$TargetCopyWithImpl<$Res, _$TargetImpl>
    implements _$$TargetImplCopyWith<$Res> {
  __$$TargetImplCopyWithImpl(
      _$TargetImpl _value, $Res Function(_$TargetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? target = null,
    Object? reached = null,
    Object? userId = null,
    Object? time = freezed,
  }) {
    return _then(_$TargetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TargetType,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as int,
      reached: null == reached
          ? _value.reached
          : reached // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      time: freezed == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TargetImpl implements _Target {
  const _$TargetImpl(
      {this.id = "",
      this.type = TargetType.step,
      this.target = 0,
      this.reached = 0,
      this.userId = "",
      @JsonKey(name: "time", fromJson: _sendAtFromJson) this.time});

  factory _$TargetImpl.fromJson(Map<String, dynamic> json) =>
      _$$TargetImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final TargetType type;
  @override
  @JsonKey()
  final int target;
  @override
  @JsonKey()
  final int reached;
  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey(name: "time", fromJson: _sendAtFromJson)
  final DateTime? time;

  @override
  String toString() {
    return 'Target(id: $id, type: $type, target: $target, reached: $reached, userId: $userId, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TargetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.reached, reached) || other.reached == reached) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.time, time) || other.time == time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, target, reached, userId, time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TargetImplCopyWith<_$TargetImpl> get copyWith =>
      __$$TargetImplCopyWithImpl<_$TargetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TargetImplToJson(
      this,
    );
  }
}

abstract class _Target implements Target {
  const factory _Target(
      {final String id,
      final TargetType type,
      final int target,
      final int reached,
      final String userId,
      @JsonKey(name: "time", fromJson: _sendAtFromJson)
      final DateTime? time}) = _$TargetImpl;

  factory _Target.fromJson(Map<String, dynamic> json) = _$TargetImpl.fromJson;

  @override
  String get id;
  @override
  TargetType get type;
  @override
  int get target;
  @override
  int get reached;
  @override
  String get userId;
  @override
  @JsonKey(name: "time", fromJson: _sendAtFromJson)
  DateTime? get time;
  @override
  @JsonKey(ignore: true)
  _$$TargetImplCopyWith<_$TargetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
