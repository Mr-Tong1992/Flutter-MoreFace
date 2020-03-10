// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeSettings _$HomeSettingsFromJson(Map<String, dynamic> json) {
      final functionList = json['functionList'] as List;
      List<HomeSettingFunction> functions = functionList?.map((value) => HomeSettingFunction.fromJson(value))?.toList();
  return HomeSettings(
      backgroundStat: json['backgroundStat'] as int,
      cardAppid: json['cardAppid'] as String,
      cardShow: json['cardShow'] as int,
      cardUrl: json['cardUrl'] as String,
      dataVersion: json['dataVersion'] as int,
      icon: json['icon'] as int,
      imgState: json['imgState'] as int,
      imgUrl: json['imgUrl'] as String,
      numSwitch: json['numSwitch'] as int,
      orgSwitch: json['orgSwitch'] as int,
      pic: json['pic'] as int,
      searchContent: json['searchContent'] as String,
      starSwitch: json['starSwitch'] as int,
      weatherStat: json['weatherStat'] as int,
      weatherCode: json['weatherCode'] as String,
      dimension: json['dimension'] as int,
      weatherExtra: json['weatherExtra'] as int,
      weatherStyle: json['weatherStyle'] as int,
      functionList: functions ?? [],
      defaultColor: json['defaultColor'] as int,
      headerMargin: json['headerMargin'] as double);
}

Map<String, dynamic> _$HomeSettingsToJson(HomeSettings instance) =>
    <String, dynamic>{
      'backgroundStat': instance.backgroundStat,
      'cardAppid': instance.cardAppid,
      'cardShow': instance.cardShow,
      'cardUrl': instance.cardUrl,
      'dataVersion': instance.dataVersion,
      'icon': instance.icon,
      'imgState': instance.imgState,
      'imgUrl': instance.imgUrl,
      'numSwitch': instance.numSwitch,
      'orgSwitch': instance.orgSwitch,
      'pic': instance.pic,
      'searchContent': instance.searchContent,
      'starSwitch': instance.starSwitch,
      'weatherStat': instance.weatherStat,
      'weatherCode': instance.weatherCode,
      'dimension': instance.dimension,
      'weatherExtra': instance.weatherExtra,
      'weatherStyle': instance.weatherStyle,
      'functionList': instance.functionList,
      'defaultColor': instance.defaultColor,
      'headerMargin': instance.headerMargin,
    };
