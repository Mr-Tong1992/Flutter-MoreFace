// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Region _$RegionFromJson(Map<String, dynamic> json) {
  return Region(
    json['district'] as String,
    json['seq'] as int,
    json['title'] as String,
    json['type'] as int,
  );
}

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
      'district': instance.district,
      'seq': instance.seq,
      'title': instance.title,
      'type': instance.type,
    };
