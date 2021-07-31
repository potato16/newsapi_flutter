import 'package:json_annotation/json_annotation.dart';

part 'exceptions.g.dart';

@JsonSerializable()
class ServerException implements Exception {
  ServerException({this.code, this.status, this.message});
  final String? code;
  final String? status;
  final String? message;
  factory ServerException.fromJson(Map<String, dynamic> json) =>
      _$ServerExceptionFromJson(json);
  Map<String, dynamic> toJson() => _$ServerExceptionToJson(this);
}

class CacheException implements Exception {}
