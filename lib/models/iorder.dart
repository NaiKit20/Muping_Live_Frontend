import 'package:json_annotation/json_annotation.dart';

part 'iorder.g.dart';

@JsonSerializable()
class Iorder {
  Iorder();

  late num oid;
  late String time;
  late String name;
  late num total;
  late num status;
  late num phone;
  late String address;
  
  factory Iorder.fromJson(Map<String,dynamic> json) => _$IorderFromJson(json);
  Map<String, dynamic> toJson() => _$IorderToJson(this);
}
