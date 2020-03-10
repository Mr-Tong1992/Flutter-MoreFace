import 'package:json_annotation/json_annotation.dart';

import 'home_setting_function.dart';

part 'home_settings.g.dart';

@JsonSerializable()
class HomeSettings extends Object {
  /// 背景动效开关 0：关闭  1：开启
  int backgroundStat;

  /// 卡证应用 APPID
  String cardAppid;

  int cardShow;

  /// 卡证应用URL
  String cardUrl;

  int dataVersion;

  int icon;

  /// 0：显示默认  1：显示配置信息
  int imgState;

  /// 背景链接
  String imgUrl;

  int numSwitch;

  /// 委办局服务开关
  int orgSwitch;

  int pic;

  /// 搜索框文字
  String searchContent;

  int starSwitch;

  /// 天气动效开关 0：关闭  1：开启
  int weatherStat;

  /// 天气编码
  String weatherCode;

  /// 服务切换纬度 0：无  1：区域  2：角色
  int dimension;

  ///天气附属显示 0：不显示 1：限行 2：步数 3：天气质量
  int weatherExtra;

  ///天气样式 0：不显示 1:宁德样式 2：福州样式
  int weatherStyle;

  ///搜索右侧功能列表id 0：占位 1：扫一扫 2：二维码 3：小铃铛 4：福码
  List<HomeSettingFunction> functionList;

  ///初始文字颜色 1：浅色 2：深色
  int defaultColor;

  ///距离 ListView距离顶部的距离
  double headerMargin;

  HomeSettings({this.backgroundStat,
    this.cardAppid,
    this.cardShow,
    this.cardUrl,
    this.dataVersion,
    this.icon,
    this.imgState,
    this.imgUrl,
    this.numSwitch,
    this.orgSwitch,
    this.pic,
    this.searchContent,
    this.starSwitch,
    this.weatherStat,
    this.weatherCode,
    this.dimension,
    this.weatherExtra,
    this.weatherStyle,
    this.functionList,
    this.defaultColor,
    this.headerMargin
  });

  factory HomeSettings.fromJson(Map<String, dynamic> srcJson) =>
      _$HomeSettingsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeSettingsToJson(this);

  /// 天气是否一致
  bool isWeatherCodeEqual(String weatherCode) {
    return this.weatherCode == weatherCode;
  }

  /// 配置是否一致
  bool isSettingsEqual(HomeSettings settings) {
    if (this.backgroundStat != settings.backgroundStat) {
      return false;
    }
    if (this.imgUrl != settings.imgUrl) {
      return false;
    }
    if (this.weatherStat != settings.weatherStat) {
      return false;
    }
    if (this.imgState != settings.imgState) {
      return false;
    }
    if (this.weatherExtra != settings.weatherExtra) {
      return false;
    }
    if (this.weatherStyle != settings.weatherStyle) {
      return false;
    }
    if (this.defaultColor != settings.defaultColor) {
      return false;
    }
    if (this.headerMargin != settings.headerMargin) {
      return false;
    }
    return true;
  }
}
