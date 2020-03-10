import 'package:json_annotation/json_annotation.dart';

part 'role.g.dart';

@JsonSerializable()
class Role extends Object {

  String role;

  String title;

  Role(this.role,this.title,);

  factory Role.fromJson(Map<String, dynamic> srcJson) => _$RoleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RoleToJson(this);

}

