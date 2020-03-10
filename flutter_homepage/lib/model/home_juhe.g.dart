// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_juhe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeJuHe _$HomeJuHeFromJson(Map<String, dynamic> json) {
  return HomeJuHe(
    AQI: json['AQI'] as String ?? '',
    carLimitNumbers: json['carLimitNumbers'] as String ?? '',
    isCarLimit: json['isCarLimit'] as int,
    quality: json['quality'] as String ?? '',
    qualityEN: json['qualityEN'] as String ?? '',
    temperature: json['temperature'] as String ?? '',
    warningInfo: json['warningInfo'] as String ?? '',
    warningInfoUrl: json['warningInfoUrl'] as String ?? '',
    weather: json['weather'] as String ?? '',
    weatherCode: json['weatherCode'] as String ?? '',
    weatherEN: json['weatherEN'] as String ?? '',
    weatherIcon: json['weatherIcon'] as String ?? '',
    weatherExtra: json['weatherExtra'] as int,
    weatherStyle: json['weatherStyle'] as int,
    defaultColor: json['defaultColor'] as int,
    headerMargin: json['headerMargin'] as int,
  );
}

Map<String, dynamic> _$HomeJuHeToJson(HomeJuHe instance) => <String, dynamic>{
      'AQI': instance.AQI,
      'carLimitNumbers': instance.carLimitNumbers,
      'isCarLimit': instance.isCarLimit,
      'quality': instance.quality,
      'qualityEN': instance.qualityEN,
      'temperature': instance.temperature,
      'warningInfo': instance.warningInfo,
      'warningInfoUrl': instance.warningInfoUrl,
      'weather': instance.weather,
      'weatherCode': instance.weatherCode,
      'weatherEN': instance.weatherEN,
      'weatherIcon': instance.weatherIcon,
  'weatherExtra': instance.weatherExtra,
  'weatherStyle': instance.weatherStyle,
  'defaultColor': instance.defaultColor,
  'headerMargin': instance.headerMargin,
    };
