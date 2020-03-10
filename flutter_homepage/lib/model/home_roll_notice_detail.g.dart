// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_roll_notice_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeRollNoticeDetail _$HomeRollNoticeDetailFromJson(Map<String, dynamic> json) {
  return HomeRollNoticeDetail(
    nid: json['nid'] as int,
    title: json['title'] as String,
    link: json['link'] as String,
    tag: json['tag'] as String,
    content: json['content'] as String,
    linkType: json['linkType'] as int,
//    linkApp: json['linkApp'] == null
//        ? null
//        : ServicesApp.fromJson(json['linkApp'] as Map<String, dynamic>),
    createDate: json['createDate'] as int,
    updateDate: json['updateDate'] as int,
    publishTime: json['publishTime'] as int,
  );
}

Map<String, dynamic> _$HomeRollNoticeDetailToJson(HomeRollNoticeDetail instance) =>
    <String, dynamic>{
      'nid': instance.nid,
      'title': instance.title,
      'link': instance.link,
      'tag': instance.tag,
      'content': instance.content,
      'linkType': instance.linkType,
      'createDate': instance.createDate,
      'updateDate': instance.updateDate,
      'publishTime': instance.publishTime,
    };
