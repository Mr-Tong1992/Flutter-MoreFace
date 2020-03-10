import 'package:flutter_homepage/model/services_app.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_roll_notice_detail.g.dart';

@JsonSerializable()

class HomeRollNoticeDetail extends Object {

  int nid;//公告id

  String title;//公告标题

  String link; //公告链接

  String tag; //标签

  String content;

  int linkType;//0：公告详情，1：外链，2： 应用

  int createDate;

  int updateDate;

  int publishTime;

  HomeRollNoticeDetail({this.nid,this.title,this.link,this.tag,this.content,this.linkType,this.createDate,this.updateDate,this.publishTime});

  factory HomeRollNoticeDetail.fromJson(Map<String, dynamic> srcJson) => _$HomeRollNoticeDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeRollNoticeDetailToJson(this);

}