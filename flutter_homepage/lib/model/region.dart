import 'package:json_annotation/json_annotation.dart';

part 'region.g.dart';

@JsonSerializable()
class Region extends Object {

  String district;

  int seq;

  String title;

  int type;

  Region(this.district,this.seq,this.title,this.type,);

  factory Region.fromJson(Map<String, dynamic> srcJson) => _$RegionFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RegionToJson(this);

}
