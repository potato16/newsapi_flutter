import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:newsapi_flutter/src/core/util/enviroment_const.dart';
import 'package:newsapi_flutter/src/model/data_sources/articles_remote_data_source.dart';
import 'package:newsapi_flutter/src/model/data_sources/user_preferences_local_data_source.dart';
import 'package:newsapi_flutter/src/model/repository/articles_repository.dart';
import 'package:newsapi_flutter/src/model/repository/user_pref_repository.dart';
import 'package:newsapi_flutter/src/view_model/usecases/get_everything_articles_usecase.dart';
import 'package:newsapi_flutter/src/view_model/usecases/get_top_headlines_usecase.dart';
import 'package:newsapi_flutter/src/view_model/usecases/get_user_preferences_usecase.dart';
import 'package:newsapi_flutter/src/view_model/usecases/save_user_preferences_usecase.dart';

/// Common
final messageProvider = StateProvider<String?>((ref) => null);
final sharedPreferencesProvider =
    StateProvider<SharedPreferences?>((ref) => null);

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
final userPrefLocalDataSourceProvider = Provider((ref) =>
    UserPrefLocalDataSourceImpl(
        sharedPreferences: ref.read(sharedPreferencesProvider).state!));

/// Repositories
final articleRepositoryProvider = Provider((ref) => ArticlesRepositoryImpl(
    remoteDataSource: ref.read(articleRemoteDataSourceProvider)));
final userPreferencesRepositoryProvider = Provider((ref) =>
    UserPreferencesRepositoryImpl(
        localDataSource: ref.read(userPrefLocalDataSourceProvider)));

/// usecases
final getEverythingUseCaseProvider = Provider(
    (ref) => GetEverythingUseCase(ref.read(articleRepositoryProvider)));
final getTopHeadlinesUseCaseProvider = Provider(
    (ref) => GetTopHeadlinesUseCase(ref.read(articleRepositoryProvider)));
final getUserPreferencesUseCaseProvider = Provider((ref) =>
    GetUserPreferencesUseCase(ref.read(userPreferencesRepositoryProvider)));
final saveUserPreferencesUseCaseProvider = Provider((ref) =>
    SaveUserPreferencesUseCase(ref.read(userPreferencesRepositoryProvider)));
