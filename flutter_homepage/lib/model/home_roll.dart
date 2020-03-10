import 'package:json_annotation/json_annotation.dart';
import '../model/home_roll_news.dart';

part 'home_roll.g.dart';

@JsonSerializable()

class HomeRoll extends Object {

  String contentIcon;

  int contentStyle;

  int contentType;

  int linkType;

  String linkUrl;

  List<HomeRollNews> rollDatas;

  int tagState;

  HomeRoll({this.contentIcon,this.contentStyle,this.contentType,this.linkType,this.linkUrl,this.rollDatas,this.tagState,});

  factory HomeRoll.fromJson(Map<String, dynamic> srcJson) => _$HomeRollFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeRollToJson(this);


}
