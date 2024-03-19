// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'run_target.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RunTarget _$RunTargetFromJson(Map<String, dynamic> json) {
  return _RunTarget.fromJson(json);
}

/// @nodoc
mixin _$RunTarget {
  String get id => throw _privateConstructorUsedError;
  TargetType get type => throw _privateConstructorUsedError;
  int get target => throw _privateConstructorUsedError;
  int get reached => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RunTargetCopyWith<RunTarget> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RunTargetCopyWith<$Res> {
  factory $RunTargetCopyWith(RunTarget value, $Res Function(RunTarget) then) =
      _$RunTargetCopyWithImpl<$Res, RunTarget>;
  @useResult
  $Res call(
      {String id, TargetType type, int target, int reached, UserModel user});

  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$RunTargetCopyWithImpl<$Res, $Val extends RunTarget>
    implements $RunTargetCopyWith<$Res> {
  _$RunTargetCopyWithImpl(this._value, this._then);

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
    Object? user = null,
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
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RunTargetImplCopyWith<$Res>
    implements $RunTargetCopyWith<$Res> {
  factory _$$RunTargetImplCopyWith(
          _$RunTargetImpl value, $Res Function(_$RunTargetImpl) then) =
      __$$RunTargetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, TargetType type, int target, int reached, UserModel user});

  @override
  $UserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$RunTargetImplCopyWithImpl<$Res>
    extends _$RunTargetCopyWithImpl<$Res, _$RunTargetImpl>
    implements _$$RunTargetImplCopyWith<$Res> {
  __$$RunTargetImplCopyWithImpl(
      _$RunTargetImpl _value, $Res Function(_$RunTargetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? target = null,
    Object? reached = null,
    Object? user = null,
  }) {
    return _then(_$RunTargetImpl(
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
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RunTargetImpl implements _RunTarget {
  const _$RunTargetImpl(
      {required this.id,
      required this.type,
      required this.target,
      required this.reached,
      required this.user});

  factory _$RunTargetImpl.fromJson(Map<String, dynamic> json) =>
      _$$RunTargetImplFromJson(json);

  @override
  final String id;
  @override
  final TargetType type;
  @override
  final int target;
  @override
  final int reached;
  @override
  final UserModel user;

  @override
  String toString() {
    return 'RunTarget(id: $id, type: $type, target: $target, reached: $reached, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RunTargetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.reached, reached) || other.reached == reached) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, target, reached, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RunTargetImplCopyWith<_$RunTargetImpl> get copyWith =>
      __$$RunTargetImplCopyWithImpl<_$RunTargetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RunTargetImplToJson(
      this,
    );
  }
}

abstract class _RunTarget implements RunTarget {
  const factory _RunTarget(
      {required final String id,
      required final TargetType type,
      required final int target,
      required final int reached,
      required final UserModel user}) = _$RunTargetImpl;

  factory _RunTarget.fromJson(Map<String, dynamic> json) =
      _$RunTargetImpl.fromJson;

  @override
  String get id;
  @override
  TargetType get type;
  @override
  int get target;
  @override
  int get reached;
  @override
  UserModel get user;
  @override
  @JsonKey(ignore: true)
  _$$RunTargetImplCopyWith<_$RunTargetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
