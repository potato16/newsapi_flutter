// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exceptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerException _$ServerExceptionFromJson(Map<String, dynamic> json) {
  return ServerException(
    code: json['code'] as String?,
    status: json['status'] as String?,
    message: json['message'] as String?,
  );
}

Map<String, dynamic> _$ServerExceptionToJson(ServerException instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
    };
