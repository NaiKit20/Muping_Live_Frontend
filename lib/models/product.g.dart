// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product()
  ..proID = json['proID'] as num
  ..name = json['name'] as String
  ..price = json['price'] as num
  ..type = json['type'] as String
  ..image = json['image'] as String;

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'proID': instance.proID,
      'name': instance.name,
      'price': instance.price,
      'type': instance.type,
      'image': instance.image,
    };
