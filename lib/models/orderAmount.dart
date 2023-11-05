import 'package:json_annotation/json_annotation.dart';

part 'orderAmount.g.dart';

@JsonSerializable()
class OrderAmount {
  OrderAmount();

  late String image;
  late num proID;
  late String name;
  late num price;
  late num amount;
  
  factory OrderAmount.fromJson(Map<String,dynamic> json) => _$OrderAmountFromJson(json);
  Map<String, dynamic> toJson() => _$OrderAmountToJson(this);
}
