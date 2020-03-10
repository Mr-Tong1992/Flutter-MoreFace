import 'package:json_annotation/json_annotation.dart';

part 'home_juhe.g.dart';

@JsonSerializable()

class HomeJuHe extends Object {

  String AQI;

  String carLimitNumbers;

  int isCarLimit;

  String quality;

  String qualityEN;

  String temperature;

  String warningInfo;

  String warningInfoUrl;

  String weather;

  String weatherCode;

  String weatherEN;

  String weatherIcon;

  int weatherExtra;

  int weatherStyle;

  int defaultColor;

  int headerMargin;

  HomeJuHe({
    this.AQI,
    this.carLimitNumbers,
    this.isCarLimit,
    this.quality,
    this.qualityEN,
    this.temperature,
    this.warningInfo,
    this.warningInfoUrl,
    this.weather,
    this.weatherCode,
    this.weatherEN,
    this.weatherIcon,
    this.weatherExtra,
    this.weatherStyle,
    this.defaultColor,
    this.headerMargin,
  });

  factory HomeJuHe.fromJson(Map<String, dynamic> srcJson) => _$HomeJuHeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeJuHeToJson(this);

}
