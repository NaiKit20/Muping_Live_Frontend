// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productInCart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInCart _$ProductInCartFromJson(Map<String, dynamic> json) =>
    ProductInCart()
      ..image = json['image'] as String
      ..proID = json['proID'] as num
      ..name = json['name'] as String
      ..price = json['price'] as num
      ..amount = json['amount'] as num;

Map<String, dynamic> _$ProductInCartToJson(ProductInCart instance) =>
    <String, dynamic>{
      'image': instance.image,
      'proID': instance.proID,
      'name': instance.name,
      'price': instance.price,
      'amount': instance.amount,
    };
