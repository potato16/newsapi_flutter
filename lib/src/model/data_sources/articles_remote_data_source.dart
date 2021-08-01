import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import 'package:newsapi_flutter/src/core/error/exceptions.dart';
import 'package:newsapi_flutter/src/model/models/articles_response.dart';
import 'package:newsapi_flutter/src/model/models/everything_param.dart';
import 'package:newsapi_flutter/src/model/models/headlines_param.dart';

abstract class ArticlesRemoteDataSource {
  Future<ArticlesResponse> fetchHeadlines(HeadLinesParams params);
  Future<ArticlesResponse> fetchEverything(EveryThingParams params);
}

class ArticlesRemoteDataSourceImpl extends ArticlesRemoteDataSource {
  ArticlesRemoteDataSourceImpl({required this.dio});
  final Dio dio;
  @override
  Future<ArticlesResponse> fetchEverything(EveryThingParams params) async {
    final response = await dio.get(
      '/everything',
      queryParameters: params.toJson(),
      options: buildCacheOptions(Duration(days: 7)),
    );
    if (response.statusCode == HttpStatus.ok) {
      return ArticlesResponse.fromJson(response.data);
    } else {
      // try to get error response
      throw ServerException.fromJson(response.data ?? {});
    }
  }

  @override
  Future<ArticlesResponse> fetchHeadlines(HeadLinesParams params) async {
    final response = await dio.get(
      '/top-headlines',
      queryParameters: params.toJson(),
      options: buildCacheOptions(Duration(days: 7)),
    );
    if (response.statusCode == HttpStatus.ok) {
      return ArticlesResponse.fromJson(response.data);
    } else {
      // try to get error response
      throw ServerException.fromJson(response.data ?? {});
    }
  }
}
