import 'package:json_annotation/json_annotation.dart';

part 'services_app.g.dart';

@JsonSerializable()

class ServicesApp {

  String androidUrl;

  String appIcon;

  int appId;

  String appPic;

  String appSubTitle;

  String appTitle;

  int appType;  // 应用类型： 0：默认应用   1：三方应用

  String appUrl;

  int auxiliaryStatus;

  String auxiliaryText;

  String ghostTitle;

  int id;

  String iosUrl;

  int isAuthentication;

  int isRecomment;

  String keywords;

  int recentlyUse;

  int starLevel;

  int starLevelReal;

  int starLevelState;

  int state;

  int useNum;

  int useNumReal;

  int useNumState;

  int isOrg;  // 1. 组织应用  0. 正常应用

  String sort;

  String appCategory;

  ServicesApp({this.androidUrl,this.appIcon,this.appId,this.appPic,this.appSubTitle,this.appTitle,this.appType,this.appUrl,this.auxiliaryStatus,this.auxiliaryText,this.ghostTitle,this.id,this.iosUrl,this.isAuthentication,this.isRecomment,this.keywords,this.recentlyUse,this.starLevel,this.starLevelReal,this.starLevelState,this.state,this.useNum,this.useNumReal,this.useNumState,this.isOrg,this.sort,this.appCategory});

  factory ServicesApp.fromJson(Map<String, dynamic> srcJson) => _$ServicesAppFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ServicesAppToJson(this);

}