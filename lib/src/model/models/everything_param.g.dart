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
    page: json['page'] as int,
  );
}

Map<String, dynamic> _$EveryThingParamsToJson(EveryThingParams instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('q', instance.q);
  writeNotNull('qInTitle', instance.qInTitle);
  writeNotNull('sources', instance.sources);
  writeNotNull('domains', instance.domains);
  writeNotNull('excludeDomains', instance.excludeDomains);
  writeNotNull('from', instance.from);
  writeNotNull('to', instance.to);
  writeNotNull('language', instance.language);
  writeNotNull('sortBy', instance.sortBy);
  writeNotNull('pageSize', instance.pageSize);
  val['page'] = instance.page;
  return val;
}
