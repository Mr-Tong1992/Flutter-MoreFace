// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_roll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeRoll _$HomeRollFromJson(Map<String, dynamic> json) {

  final originList = json['rollDatas'] as List;
  List<HomeRollNews> rolls = originList.map((value) => HomeRollNews.fromJson(value)).toList();

  return HomeRoll(
    contentIcon: json['contentIcon'] as String,
    contentStyle: json['contentStyle'] as int,
    contentType: json['contentType'] as int,
    linkType: json['linkType'] as int,
    linkUrl: json['linkUrl'] as String,
    rollDatas: rolls,
    tagState: json['tagState'] as int,
  );
}

Map<String, dynamic> _$HomeRollToJson(HomeRoll instance) => <String, dynamic>{
      'contentIcon': instance.contentIcon,
      'contentStyle': instance.contentStyle,
      'contentType': instance.contentType,
      'linkType': instance.linkType,
      'linkUrl': instance.linkUrl,
      'rollDatas': instance.rollDatas,
      'tagState': instance.tagState,
    };
