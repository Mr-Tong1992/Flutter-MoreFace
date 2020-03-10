import 'package:json_annotation/json_annotation.dart';

part 'home_roll_news_detail.g.dart';

@JsonSerializable()

class HomeRollNewsDetail extends Object {

  String contentId;

  int createTime;

  String fileUrl;

  int showType;

  int tagType;

  String title;

  HomeRollNewsDetail({this.contentId,this.createTime,this.fileUrl,this.showType,this.tagType,this.title,});

  factory HomeRollNewsDetail.fromJson(Map<String, dynamic> srcJson) => _$HomeRollNewsDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeRollNewsDetailToJson(this);

}