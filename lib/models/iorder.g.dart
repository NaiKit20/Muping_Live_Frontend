// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'iorder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Iorder _$IorderFromJson(Map<String, dynamic> json) => Iorder()
  ..oid = json['oid'] as num
  ..time = json['time'] as String
  ..name = json['name'] as String
  ..total = json['total'] as num
  ..status = json['status'] as num
  ..phone = json['phone'] as num
  ..address = json['address'] as String;

Map<String, dynamic> _$IorderToJson(Iorder instance) => <String, dynamic>{
      'oid': instance.oid,
      'time': instance.time,
      'name': instance.name,
      'total': instance.total,
      'status': instance.status,
      'phone': instance.phone,
      'address': instance.address,
    };
