// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'headlines_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeadLinesParams _$HeadLinesParamsFromJson(Map<String, dynamic> json) {
  return HeadLinesParams(
    country: json['country'] as String?,
    category: json['category'] as String?,
    sources: json['sources'] as String?,
    q: json['q'] as String?,
    pageSize: json['pageSize'] as int?,
    page: json['page'] as int,
  );
}

Map<String, dynamic> _$HeadLinesParamsToJson(HeadLinesParams instance) =>
    <String, dynamic>{
      'country': instance.country,
      'category': instance.category,
      'sources': instance.sources,
      'q': instance.q,
      'pageSize': instance.pageSize,
      'page': instance.page,
    };
