// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodModelImpl _$$FoodModelImplFromJson(Map<String, dynamic> json) =>
    _$FoodModelImpl(
      Id: json['Id'] as String,
      Name: json['Name'] as String,
      Weight: json['Weight'] as String,
      ImageLink: json['ImageLink'] as String,
      Description: json['Description'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$FoodModelImplToJson(_$FoodModelImpl instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'Name': instance.Name,
      'Weight': instance.Weight,
      'ImageLink': instance.ImageLink,
      'Description': instance.Description,
      'url': instance.url,
    };
