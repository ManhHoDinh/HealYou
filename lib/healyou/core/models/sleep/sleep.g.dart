// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SleepImpl _$$SleepImplFromJson(Map<String, dynamic> json) => _$SleepImpl(
      id: json['id'] as String? ?? null,
      startTime: _sendDateTimeFromJson(json['startTime'] as Timestamp),
      endTime: _sendDateTimeFromJson(json['endTime'] as Timestamp),
      color: json['color'] == null
          ? Colors.greenAccent
          : _sendColorFromJson((json['color'] as num).toInt()),
      sleepTime: json['sleepTime'] == null
          ? const <DateTime>[]
          : _sendSleepTimesListFromJson(json['sleepTime'] as List),
    );

Map<String, dynamic> _$$SleepImplToJson(_$SleepImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': _sendDateTimeToJson(instance.startTime),
      'endTime': _sendDateTimeToJson(instance.endTime),
      'color': _sendColorToJson(instance.color),
      'sleepTime': _sendSleepTimesListToJson(instance.sleepTime),
    };
