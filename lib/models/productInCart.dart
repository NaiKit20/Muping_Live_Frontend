import 'package:json_annotation/json_annotation.dart';

part 'productInCart.g.dart';

@JsonSerializable()
class ProductInCart {
  ProductInCart();

  late String image;
  late num proID;
  late String name;
  late num price;
  late num amount;
  
  factory ProductInCart.fromJson(Map<String,dynamic> json) => _$ProductInCartFromJson(json);
  Map<String, dynamic> toJson() => _$ProductInCartToJson(this);
}
