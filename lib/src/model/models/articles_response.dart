import 'package:json_annotation/json_annotation.dart';

import 'package:newsapi_flutter/src/model/models/article.dart';

part 'articles_response.g.dart';

@JsonSerializable()
class ArticlesResponse {
  ArticlesResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });
  @JsonKey(defaultValue: '')
  final String status;
  @JsonKey(defaultValue: 0)
  final int totalResults;
  @JsonKey(defaultValue: [])
  final List<Article> articles;
  factory ArticlesResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticlesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArticlesResponseToJson(this);
}
