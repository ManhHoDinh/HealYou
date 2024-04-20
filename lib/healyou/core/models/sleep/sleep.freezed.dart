// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sleep.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Sleep _$SleepFromJson(Map<String, dynamic> json) {
  return _Sleep.fromJson(json);
}

/// @nodoc
mixin _$Sleep {
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(
      name: "startTime",
      fromJson: _sendDateTimeFromJson,
      toJson: _sendDateTimeToJson)
  DateTime get startTime => throw _privateConstructorUsedError;
  @JsonKey(
      name: "endTime",
      fromJson: _sendDateTimeFromJson,
      toJson: _sendDateTimeToJson)
  DateTime get endTime => throw _privateConstructorUsedError;
  @JsonKey(
      name: "color", fromJson: _sendColorFromJson, toJson: _sendColorToJson)
  Color? get color => throw _privateConstructorUsedError;
  @JsonKey(
      name: "sleepTime",
      fromJson: _sendSleepTimesListFromJson,
      toJson: _sendSleepTimesListToJson)
  List<DateTime> get sleepTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SleepCopyWith<Sleep> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SleepCopyWith<$Res> {
  factory $SleepCopyWith(Sleep value, $Res Function(Sleep) then) =
      _$SleepCopyWithImpl<$Res, Sleep>;
  @useResult
  $Res call(
      {String? id,
      @JsonKey(
          name: "startTime",
          fromJson: _sendDateTimeFromJson,
          toJson: _sendDateTimeToJson)
      DateTime startTime,
      @JsonKey(
          name: "endTime",
          fromJson: _sendDateTimeFromJson,
          toJson: _sendDateTimeToJson)
      DateTime endTime,
      @JsonKey(
          name: "color", fromJson: _sendColorFromJson, toJson: _sendColorToJson)
      Color? color,
      @JsonKey(
          name: "sleepTime",
          fromJson: _sendSleepTimesListFromJson,
          toJson: _sendSleepTimesListToJson)
      List<DateTime> sleepTime});
}

/// @nodoc
class _$SleepCopyWithImpl<$Res, $Val extends Sleep>
    implements $SleepCopyWith<$Res> {
  _$SleepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? color = freezed,
    Object? sleepTime = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      sleepTime: null == sleepTime
          ? _value.sleepTime
          : sleepTime // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SleepImplCopyWith<$Res> implements $SleepCopyWith<$Res> {
  factory _$$SleepImplCopyWith(
          _$SleepImpl value, $Res Function(_$SleepImpl) then) =
      __$$SleepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @JsonKey(
          name: "startTime",
          fromJson: _sendDateTimeFromJson,
          toJson: _sendDateTimeToJson)
      DateTime startTime,
      @JsonKey(
          name: "endTime",
          fromJson: _sendDateTimeFromJson,
          toJson: _sendDateTimeToJson)
      DateTime endTime,
      @JsonKey(
          name: "color", fromJson: _sendColorFromJson, toJson: _sendColorToJson)
      Color? color,
      @JsonKey(
          name: "sleepTime",
          fromJson: _sendSleepTimesListFromJson,
          toJson: _sendSleepTimesListToJson)
      List<DateTime> sleepTime});
}

/// @nodoc
class __$$SleepImplCopyWithImpl<$Res>
    extends _$SleepCopyWithImpl<$Res, _$SleepImpl>
    implements _$$SleepImplCopyWith<$Res> {
  __$$SleepImplCopyWithImpl(
      _$SleepImpl _value, $Res Function(_$SleepImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? color = freezed,
    Object? sleepTime = null,
  }) {
    return _then(_$SleepImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      sleepTime: null == sleepTime
          ? _value._sleepTime
          : sleepTime // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SleepImpl implements _Sleep {
  _$SleepImpl(
      {this.id = null,
      @JsonKey(
          name: "startTime",
          fromJson: _sendDateTimeFromJson,
          toJson: _sendDateTimeToJson)
      required this.startTime,
      @JsonKey(
          name: "endTime",
          fromJson: _sendDateTimeFromJson,
          toJson: _sendDateTimeToJson)
      required this.endTime,
      @JsonKey(
          name: "color", fromJson: _sendColorFromJson, toJson: _sendColorToJson)
      this.color = Colors.greenAccent,
      @JsonKey(
          name: "sleepTime",
          fromJson: _sendSleepTimesListFromJson,
          toJson: _sendSleepTimesListToJson)
      final List<DateTime> sleepTime = const <DateTime>[]})
      : _sleepTime = sleepTime;

  factory _$SleepImpl.fromJson(Map<String, dynamic> json) =>
      _$$SleepImplFromJson(json);

  @override
  @JsonKey()
  final String? id;
  @override
  @JsonKey(
      name: "startTime",
      fromJson: _sendDateTimeFromJson,
      toJson: _sendDateTimeToJson)
  final DateTime startTime;
  @override
  @JsonKey(
      name: "endTime",
      fromJson: _sendDateTimeFromJson,
      toJson: _sendDateTimeToJson)
  final DateTime endTime;
  @override
  @JsonKey(
      name: "color", fromJson: _sendColorFromJson, toJson: _sendColorToJson)
  final Color? color;
  final List<DateTime> _sleepTime;
  @override
  @JsonKey(
      name: "sleepTime",
      fromJson: _sendSleepTimesListFromJson,
      toJson: _sendSleepTimesListToJson)
  List<DateTime> get sleepTime {
    if (_sleepTime is EqualUnmodifiableListView) return _sleepTime;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sleepTime);
  }

  @override
  String toString() {
    return 'Sleep(id: $id, startTime: $startTime, endTime: $endTime, color: $color, sleepTime: $sleepTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SleepImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality()
                .equals(other._sleepTime, _sleepTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, startTime, endTime, color,
      const DeepCollectionEquality().hash(_sleepTime));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SleepImplCopyWith<_$SleepImpl> get copyWith =>
      __$$SleepImplCopyWithImpl<_$SleepImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SleepImplToJson(
      this,
    );
  }
}

abstract class _Sleep implements Sleep {
  factory _Sleep(
      {final String? id,
      @JsonKey(
          name: "startTime",
          fromJson: _sendDateTimeFromJson,
          toJson: _sendDateTimeToJson)
      required final DateTime startTime,
      @JsonKey(
          name: "endTime",
          fromJson: _sendDateTimeFromJson,
          toJson: _sendDateTimeToJson)
      required final DateTime endTime,
      @JsonKey(
          name: "color", fromJson: _sendColorFromJson, toJson: _sendColorToJson)
      final Color? color,
      @JsonKey(
          name: "sleepTime",
          fromJson: _sendSleepTimesListFromJson,
          toJson: _sendSleepTimesListToJson)
      final List<DateTime> sleepTime}) = _$SleepImpl;

  factory _Sleep.fromJson(Map<String, dynamic> json) = _$SleepImpl.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(
      name: "startTime",
      fromJson: _sendDateTimeFromJson,
      toJson: _sendDateTimeToJson)
  DateTime get startTime;
  @override
  @JsonKey(
      name: "endTime",
      fromJson: _sendDateTimeFromJson,
      toJson: _sendDateTimeToJson)
  DateTime get endTime;
  @override
  @JsonKey(
      name: "color", fromJson: _sendColorFromJson, toJson: _sendColorToJson)
  Color? get color;
  @override
  @JsonKey(
      name: "sleepTime",
      fromJson: _sendSleepTimesListFromJson,
      toJson: _sendSleepTimesListToJson)
  List<DateTime> get sleepTime;
  @override
  @JsonKey(ignore: true)
  _$$SleepImplCopyWith<_$SleepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
