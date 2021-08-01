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

Map<String, dynamic> _$HeadLinesParamsToJson(HeadLinesParams instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('country', instance.country);
  writeNotNull('category', instance.category);
  writeNotNull('sources', instance.sources);
  writeNotNull('q', instance.q);
  writeNotNull('pageSize', instance.pageSize);
  val['page'] = instance.page;
  return val;
}
