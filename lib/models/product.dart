import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  Product();

  late num proID;
  late String name;
  late num price;
  late String type;
  late String image;
  
  factory Product.fromJson(Map<String,dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
