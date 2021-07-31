import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:newsapi_flutter/src/core/error/exceptions.dart';
import 'package:newsapi_flutter/src/model/data_sources/articles_remote_data_source.dart';
import 'package:newsapi_flutter/src/model/models/articles_response.dart';
import 'package:newsapi_flutter/src/model/models/everything_param.dart';
import 'package:newsapi_flutter/src/model/models/headlines_param.dart';
import 'package:newsapi_flutter/src/model/repository/articles_repository.dart';

import 'articles_repository_test.mocks.dart';

@GenerateMocks([ArticlesRemoteDataSource])
void main() {
  late MockArticlesRemoteDataSource mockArticlesRemoteDataSource;
  late ArticlesRepository articlesRepository;
  setUp(() {
    mockArticlesRemoteDataSource = MockArticlesRemoteDataSource();
    articlesRepository =
        ArticlesRepositoryImpl(remoteDataSource: mockArticlesRemoteDataSource);
  });
  group('$ArticlesRepositoryImpl getTopHeadlines', () {
    test('fetch top headlines should be success', () async {
      when(mockArticlesRemoteDataSource.fetchHeadlines(any)).thenAnswer(
        (_) async => ArticlesResponse(
          articles: [],
          status: 'ok',
          totalResults: 0,
        ),
      );
      final params = HeadLinesParams(page: 1);
      final result = await articlesRepository.getTopHeadlines(params);
      expect(result.isRight(), isTrue);
    });
    test('fetch top headlines should be failed because invalid page params',
        () async {
      when(mockArticlesRemoteDataSource.fetchHeadlines(any)).thenAnswer(
        (_) async => ArticlesResponse(
          articles: [],
          status: 'ok',
          totalResults: 0,
        ),
      );
      expect(
          () async => await articlesRepository
              .getTopHeadlines(HeadLinesParams(page: 0)),
          throwsAssertionError);
    });
    test('fetch top headlines should be failed because server return error',
        () async {
      when(mockArticlesRemoteDataSource.fetchHeadlines(any))
          .thenThrow(ServerException());
      final params = HeadLinesParams(page: 1);
      final result = await articlesRepository.getTopHeadlines(params);
      expect(result.isLeft(), isTrue);
    });
    test('fetch top headlines should be failed because unexpected error',
        () async {
      when(mockArticlesRemoteDataSource.fetchHeadlines(any))
          .thenThrow(Exception());
      final HeadLinesParams params = HeadLinesParams(page: 1);
      final result = await articlesRepository.getTopHeadlines(params);
      expect(result.isLeft(), isTrue);
    });
  });
  group('$ArticlesRepositoryImpl getEverything', () {
    test('fetch everything should be success', () async {
      when(mockArticlesRemoteDataSource.fetchEverything(any)).thenAnswer(
        (_) async => ArticlesResponse(
          articles: [],
          status: 'ok',
          totalResults: 0,
        ),
      );
      final EveryThingParams params = EveryThingParams(page: 1, q: 'a');
      final result = await articlesRepository.getEverything(params);
      expect(result.isRight(), isTrue);
    });
    test('fetch everything should be failed because invalid page params',
        () async {
      when(mockArticlesRemoteDataSource.fetchEverything(any)).thenAnswer(
        (_) async => ArticlesResponse(
          articles: [],
          status: 'ok',
          totalResults: 0,
        ),
      );
      expect(
          () async => await articlesRepository
              .getEverything(EveryThingParams(page: 0, q: 'a')),
          throwsAssertionError);
    });
    test('fetch everything should be failed because server return error',
        () async {
      when(mockArticlesRemoteDataSource.fetchEverything(any))
          .thenThrow(ServerException());
      final EveryThingParams params = EveryThingParams(page: 1, q: 'a');
      final result = await articlesRepository.getEverything(params);
      expect(result.isLeft(), isTrue);
    });
    test('fetch everything should be failed because unexpected error',
        () async {
      when(mockArticlesRemoteDataSource.fetchEverything(any))
          .thenThrow(Exception());
      final EveryThingParams params = EveryThingParams(page: 1, q: 'a');
      final result = await articlesRepository.getEverything(params);
      expect(result.isLeft(), isTrue);
    });
  });
}
