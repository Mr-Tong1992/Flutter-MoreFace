// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppGroup _$AppGroupFromJson(Map<String, dynamic> json) {

  final originList = json['appInfoList'] as List;
  List<ServicesApp> appList = originList != null ? originList.map((value) => ServicesApp.fromJson(value)).toList() : null;


  HomeRoll roll = json['roll'] != null ? HomeRoll.fromJson(json['roll']) : null;

//  var tempJsonDecode = jsonDecode(json['templateJson']);


//   HomeTemplate template = tempJsonDecode != null &&  tempJsonDecode != "" ?  HomeTemplate.fromJson(tempJsonDecode): null;

  return AppGroup(
    appGroupId: json['appGroupId'] as int,
    appInfoList: appList,
    img: json['img'] as String,
    isOrg: json['isOrg'] as int,
    linkUrl: json['linkUrl'] as String,
    org: json['org'] as String,
    orgAppCategory: json['orgAppCategory'] as String,
    position: json['position'] as int,
    remark: json['remark'] as String,
    roll: roll,
    style: json['style'] as String,
    title: json['title'] as String,
    backGroupImg: json['backGroupImg'] as String
  );
}

Map<String, dynamic> _$AppGroupToJson(AppGroup instance) => <String, dynamic>{
      'appGroupId': instance.appGroupId,
      'appInfoList': instance.appInfoList,
      'img': instance.img,
      'isOrg': instance.isOrg,
      'linkUrl': instance.linkUrl,
      'org': instance.org,
      'orgAppCategory': instance.orgAppCategory,
      'position': instance.position,
      'remark': instance.remark,
      'style': instance.style,
      'title': instance.title,
      'roll': instance.roll,
      'backGroupImg': instance.backGroupImg,

      'templateJson': instance.templateJson,
    };
