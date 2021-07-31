// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'everything_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EveryThingParams _$EveryThingParamsFromJson(Map<String, dynamic> json) {
  return EveryThingParams(
    q: json['q'] as String?,
    qInTitle: json['qInTitle'] as String?,
    sources: json['sources'] as String?,
    domains: json['domains'] as String?,
    excludeDomains: json['excludeDomains'] as String?,
    from: json['from'] as String?,
    to: json['to'] as String?,
    language: json['language'] as String?,
    sortBy: json['sortBy'] as String?,
    pageSize: json['pageSize'] as int?,
    page: json['page'] as int?,
  );
}

Map<String, dynamic> _$EveryThingParamsToJson(EveryThingParams instance) =>
    <String, dynamic>{
      'q': instance.q,
      'qInTitle': instance.qInTitle,
      'sources': instance.sources,
      'domains': instance.domains,
      'excludeDomains': instance.excludeDomains,
      'from': instance.from,
      'to': instance.to,
      'language': instance.language,
      'sortBy': instance.sortBy,
      'pageSize': instance.pageSize,
      'page': instance.page,
    };
