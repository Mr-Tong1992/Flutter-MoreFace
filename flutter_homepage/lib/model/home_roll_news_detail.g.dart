// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_roll_news_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeRollNewsDetail _$HomeRollNewsDetailFromJson(Map<String, dynamic> json) {
  return HomeRollNewsDetail(
    contentId: json['contentId'] as String,
    createTime: json['createTime'] as int,
    fileUrl: json['fileUrl'] as String,
    showType: json['showType'] as int,
    tagType: json['tagType'] as int,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$HomeRollNewsDetailToJson(HomeRollNewsDetail instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
      'createTime': instance.createTime,
      'fileUrl': instance.fileUrl,
      'showType': instance.showType,
      'tagType': instance.tagType,
      'title': instance.title,
    };
