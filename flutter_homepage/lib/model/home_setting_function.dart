import 'package:json_annotation/json_annotation.dart';

part 'home_setting_function.g.dart';
@JsonSerializable()
class HomeSettingFunction {
  ///功能编号
  int code;

  ///名称
  String name;

  ///排序
  int sort;

  HomeSettingFunction({this.code, this.name, this.sort});

  factory HomeSettingFunction.fromJson(Map<String, dynamic> srcJson) =>
      _$HomeSettingFunctionFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeSettingFunctionToJson(this);
}
