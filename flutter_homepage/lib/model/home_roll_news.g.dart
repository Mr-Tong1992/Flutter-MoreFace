// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_roll_news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeRollNews _$HomeRollNewsFromJson(Map<String, dynamic> json) {
  return HomeRollNews(
    dataType: json['dataType'] as int,
    topline: json['topline'] == null
        ? null
        : HomeRollNewsDetail.fromJson(json['topline'] as Map<String, dynamic>),
    notice: json['notice'] == null
        ? null
        : HomeRollNoticeDetail.fromJson(json['notice'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HomeRollNewsToJson(HomeRollNews instance) =>
    <String, dynamic>{
      'dataType': instance.dataType,
      'topline': instance.topline,
      'notice': instance.notice,
    };
