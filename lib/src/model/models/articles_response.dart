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
  final String status;
  final int totalResults;
  final List<Article> articles;
  factory ArticlesResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticlesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArticlesResponseToJson(this);
}
