part of 'home_setting_function.dart';

HomeSettingFunction _$HomeSettingFunctionFromJson(Map<String, dynamic> json) {
  return HomeSettingFunction(
    code: json['code'] as int,
    name: json['name'] as String,
    sort: json['sort'] as int,
  );
}

Map<String, dynamic> _$HomeSettingFunctionToJson(HomeSettingFunction instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'sort': instance.sort,
    };
