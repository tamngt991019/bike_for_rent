// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel()
    ..username = json['username'] as String
    ..fullname = json['fullname'] as String
    ..avatar = json['avatar'] as String
    ..dateCreated = json['dateCreated'] as DateTime
    ..status = json['status'] as String;
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'username': instance.username,
      'fullname': instance.fullname,
      'avatar': instance.avatar,
      'dateCreated': instance.dateCreated,
      'status': instance.status,
    };
