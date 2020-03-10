import 'package:json_annotation/json_annotation.dart';

part 'global_settings.g.dart';


@JsonSerializable()
class GlobalSettings extends Object {

  int dimension;

  GlobalSettings({this.dimension,});

  factory GlobalSettings.fromJson(Map<String, dynamic> srcJson) => _$GlobalSettingsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GlobalSettingsToJson(this);

}


