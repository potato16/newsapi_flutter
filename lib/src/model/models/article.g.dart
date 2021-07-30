// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    source: SourceArticle.fromJson(json['source'] as Map<String, dynamic>),
    author: json['author'] as String? ?? '',
    title: json['title'] as String? ?? '',
    description: json['description'] as String? ?? '',
    url: json['url'] as String? ?? '',
    urlToImage: json['urlToImage'] as String? ?? '',
    publishedAt: json['publishedAt'] as String? ?? '',
    content: json['content'] as String? ?? '',
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'source': instance.source.toJson(),
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };

SourceArticle _$SourceArticleFromJson(Map<String, dynamic> json) {
  return SourceArticle(
    id: json['id'] as String?,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$SourceArticleToJson(SourceArticle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
