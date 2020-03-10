import 'package:json_annotation/json_annotation.dart';
import 'home_roll_news_detail.dart';
import 'home_roll_notice_detail.dart';
part 'home_roll_news.g.dart';

@JsonSerializable()

class HomeRollNews extends Object {

  int dataType;

  HomeRollNewsDetail topline;

  HomeRollNoticeDetail notice;

  HomeRollNews({this.dataType,this.topline,this.notice});

  factory HomeRollNews.fromJson(Map<String, dynamic> srcJson) => _$HomeRollNewsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeRollNewsToJson(this);

}



