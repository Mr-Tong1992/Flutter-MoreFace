// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesApp _$ServicesAppFromJson(Map<String, dynamic> json) {
  return ServicesApp(
    androidUrl: json['androidUrl'] as String,
    appIcon: json['appIcon'] as String,
    appId: json['appId'] as int,
    appPic: json['appPic'] as String,
    appSubTitle: json['appSubTitle'] as String,
    appTitle: json['appTitle'] as String,
    appType: json['appType'] as int ?? 0,
    appUrl: json['appUrl'] as String,
    auxiliaryStatus: json['auxiliaryStatus'] as int,
    auxiliaryText: json['auxiliaryText'] as String,
    ghostTitle: json['ghostTitle'] as String,
    id: json['id'] as int,
    iosUrl: json['iosUrl'] as String,
    isAuthentication: json['isAuthentication'] as int,
    isRecomment: json['isRecomment'] as int,
    keywords: json['keywords'] as String,
    recentlyUse: json['recentlyUse'] as int,
    starLevel: json['starLevel'] as int,
    starLevelReal: json['starLevelReal'] as int,
    starLevelState: json['starLevelState'] as int,
    state: json['state'] as int,
    useNum: json['useNum'] as int,
    useNumReal: json['useNumReal'] as int,
    useNumState: json['useNumState'] as int,
    isOrg: json['isOrg'] as int,
    sort: json['sort'] as String,
    appCategory: json['appCategory'] as String,
  );
}

Map<String, dynamic> _$ServicesAppToJson(ServicesApp instance) =>
    <String, dynamic>{
      'androidUrl': instance.androidUrl,
      'appIcon': instance.appIcon,
      'appId': instance.appId,
      'appPic': instance.appPic,
      'appSubTitle': instance.appSubTitle,
      'appTitle': instance.appTitle,
      'appType': instance.appType,
      'appUrl': instance.appUrl,
      'auxiliaryStatus': instance.auxiliaryStatus,
      'auxiliaryText': instance.auxiliaryText,
      'ghostTitle': instance.ghostTitle,
      'id': instance.id,
      'iosUrl': instance.iosUrl,
      'isAuthentication': instance.isAuthentication,
      'isRecomment': instance.isRecomment,
      'keywords': instance.keywords,
      'recentlyUse': instance.recentlyUse,
      'starLevel': instance.starLevel,
      'starLevelReal': instance.starLevelReal,
      'starLevelState': instance.starLevelState,
      'state': instance.state,
      'useNum': instance.useNum,
      'useNumReal': instance.useNumReal,
      'useNumState': instance.useNumState,
      'isOrg': instance.isOrg,
      'sort': instance.sort,
      'appCategory': instance.appCategory,
    };
