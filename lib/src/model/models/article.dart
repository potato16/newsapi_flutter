import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

const int maxContentLength = 200;

@JsonSerializable()
class Article with EquatableMixin {
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });
  final SourceArticle source;
  @JsonKey(defaultValue: '')
  final String author;
  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(defaultValue: '')
  final String description;
  @JsonKey(defaultValue: '')
  final String url;
  @JsonKey(defaultValue: '')
  final String urlToImage;
  @JsonKey(defaultValue: '')
  final String publishedAt;
  @JsonKey(defaultValue: '')
  final String content;
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
  @override
  List<Object?> get props => [
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
}

@JsonSerializable()
class SourceArticle with EquatableMixin {
  SourceArticle({this.id, required this.name});
  final String? id;
  final String name;

  factory SourceArticle.fromJson(Map<String, dynamic> json) =>
      _$SourceArticleFromJson(json);
  Map<String, dynamic> toJson() => _$SourceArticleToJson(this);
  @override
  List<Object?> get props => [id, name];
}
