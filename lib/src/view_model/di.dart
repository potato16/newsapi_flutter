import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:newsapi_flutter/src/core/util/enviroment_const.dart';
import 'package:newsapi_flutter/src/model/data_sources/articles_remote_data_source.dart';
import 'package:newsapi_flutter/src/model/repository/articles_repository.dart';
import 'package:newsapi_flutter/src/view_model/usecases/get_everything_articles_usecase.dart';

/// Common
final messageProvider = StateProvider<String?>((ref) => null);

final dioProvider = Provider<Dio>((ref) {
  final baseUrl = 'https://newsapi.org/v2';
  var options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: {
      'Authorization': EnviromentConst.apiKey,
    },
  );
  Dio dio = Dio(options);
  dio.interceptors
      .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);

  return dio;
});

/// Data Sources
final articleRemoteDataSourceProvider =
    Provider((ref) => ArticlesRemoteDataSourceImpl(dio: ref.read(dioProvider)));

/// Repositories
final articleRepositoryProvider = Provider((ref) => ArticlesRepositoryImpl(
    remoteDataSource: ref.read(articleRemoteDataSourceProvider)));

/// usecases
final getEverythingUseCaseProvider = Provider(
    (ref) => GetEverythingUseCase(ref.read(articleRepositoryProvider)));
