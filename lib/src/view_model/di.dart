import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:newsapi_flutter/src/core/util/enviroment_const.dart';
import 'package:newsapi_flutter/src/model/data_sources/articles_remote_data_source.dart';
import 'package:newsapi_flutter/src/model/models/article.dart';
import 'package:newsapi_flutter/src/model/repository/articles_repository.dart';
import 'package:newsapi_flutter/src/view_model/providers/customize_news_provider.dart';
import 'package:newsapi_flutter/src/view_model/usecases/get_everything_articles_usecase.dart';

/// Common
final messageProvider = StateProvider<String?>((ref) => null);
final dioProvider = Provider<Dio>((ref) {
  var options = BaseOptions(
    baseUrl: 'https://newsapi.org/v2',
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: {
      'Authorization': EnviromentConst.apiKey,
    },
  );
  Dio dio = Dio(options);

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

/// Provider
final customizeNewsProvider =
    StateNotifierProvider<CustomizeNewsStateNotifier, List<Article>>((ref) {
  return CustomizeNewsStateNotifier([],
      getArticlesUseCase: ref.read(getEverythingUseCaseProvider),
      reader: ref.read);
});
