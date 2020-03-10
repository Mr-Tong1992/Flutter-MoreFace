import 'dart:convert';

import 'package:flutter_homepage/model/home_template.dart';

import '../model/services_app.dart';
import '../model/home_roll.dart';
import 'package:json_annotation/json_annotation.dart';
part 'app_group.g.dart';

@JsonSerializable()

class AppGroup {

  int appGroupId;

  List<ServicesApp> appInfoList;

  String img;

  int isOrg;

  String linkUrl;

  String org;

  String orgAppCategory; // all 表示所有组织应用， 否则取对应分类的组织应用

  int position;

  String remark;

  String style;

  String title;

  HomeRoll roll;

  String backGroupImg;

  HomeTemplate templateJson;

  AppGroup({this.backGroupImg, this.appGroupId,this.appInfoList,this.img,this.isOrg,this.linkUrl,this.org,this.orgAppCategory,this.position,this.remark,this.roll,this.style,this.title,this.templateJson});

  factory AppGroup.fromJson(Map<String, dynamic> srcJson) => _$AppGroupFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AppGroupToJson(this);



}


