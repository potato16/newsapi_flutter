import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:newsapi_flutter/src/core/error/exceptions.dart';
import 'package:newsapi_flutter/src/model/data_sources/articles_remote_data_source.dart';
import 'package:newsapi_flutter/src/model/models/articles_response.dart';
import 'package:newsapi_flutter/src/model/models/everything_param.dart';
import 'package:newsapi_flutter/src/model/models/headlines_param.dart';

import '../../fixtures/fixture_reader.dart';
import 'articles_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio dio;
  late ArticlesRemoteDataSource dataSource;
  setUp(() {
    dio = MockDio();
    dataSource = ArticlesRemoteDataSourceImpl(dio: dio);
  });
  group('$ArticlesRemoteDataSource  fetchHeadlines', () {
    test('fetch headlines should be success', () async {
      final path = '/top-headlines';
      when(
        dio.get(
          any,
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
          cancelToken: anyNamed('cancelToken'),
          onReceiveProgress: anyNamed('onReceiveProgress'),
        ),
      ).thenAnswer(
        (_) async => Response(
            data: json.decode(fixture('articles.json')),
            requestOptions: RequestOptions(path: path),
            statusCode: 200),
      );
      var response = await dataSource.fetchHeadlines(HeadLinesParams(page: 1));
      expect(response, isA<ArticlesResponse>());
    });
    test('fetch headlines should be failed because got 500', () async {
      final path = '/top-headlines';
      when(dio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: path), statusCode: 500));
      expect(
          () async => await dataSource.fetchHeadlines(HeadLinesParams(page: 1)),
          throwsA(TypeMatcher<ServerException>()));
    });
    test('fetch headlines should be failed because got 401', () async {
      final path = '/top-headlines';
      when(dio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer((_) async => Response(
          data: json.decode(fixture('error401.json')),
          requestOptions: RequestOptions(path: path),
          statusCode: 401));

      try {
        await dataSource.fetchHeadlines(HeadLinesParams(page: 1));
        // should not go to this statement
        expect(0, 1);
      } on ServerException catch (e) {
        expect(e.code, isNotNull);
        expect(e.message, isNotNull);
        expect(e.status, isNotNull);
      }
    });
  });
  group('$ArticlesRemoteDataSource  fetchHeadlines', () {
    test('fetch headlines should be failed because page is invalid', () async {
      final path = '/top-headlines';
      when(dio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer(
        (_) async => Response(
            data: json.decode(fixture('articles.json')),
            requestOptions: RequestOptions(path: path),
            statusCode: 200),
      );
      expect(
          () async => await dataSource.fetchHeadlines(HeadLinesParams(page: 0)),
          throwsAssertionError);
    });
  });
  group('$ArticlesRemoteDataSource  fetchEverything', () {
    test('fetch headlines should be success', () async {
      final path = '/everything';
      when(dio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer(
        (_) async => Response(
            data: json.decode(fixture('articles.json')),
            requestOptions: RequestOptions(path: path),
            statusCode: 200),
      );
      var response =
          await dataSource.fetchEverything(EveryThingParams(page: 1, q: 'a'));
      expect(response, isA<ArticlesResponse>());
    });
    test('fetch headlines should be failed because got 500', () async {
      final path = '/everything';
      when(dio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: path), statusCode: 500));
      expect(
          () async => await dataSource
              .fetchEverything(EveryThingParams(page: 1, sources: 'c')),
          throwsA(TypeMatcher<ServerException>()));
    });
    test('fetch headlines should be failed because got 401', () async {
      final path = '/everything';
      when(dio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer((_) async => Response(
          data: json.decode(fixture('error401.json')),
          requestOptions: RequestOptions(path: path),
          statusCode: 401));

      try {
        await dataSource
            .fetchEverything(EveryThingParams(page: 1, qInTitle: 'a'));
        // should not go to this statement
        expect(0, 1);
      } on ServerException catch (e) {
        expect(e.code, isNotNull);
        expect(e.message, isNotNull);
        expect(e.status, isNotNull);
      }
    });
  });
  group('$ArticlesRemoteDataSource  fetchEverything', () {
    setUp(() {
      final path = '/everything';
      when(dio.get(
        any,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer(
        (_) async => Response(
            data: json.decode(fixture('error400.json')),
            requestOptions: RequestOptions(path: path),
            statusCode: 400),
      );
    });
    test('fetch headlines should be failed because queryParameters is invalid',
        () async {
      expect(
          () async =>
              await dataSource.fetchEverything(EveryThingParams(page: 1)),
          throwsAssertionError);
    });
    test('fetch headlines should be failed because page is invalid', () async {
      expect(
          () async => await dataSource
              .fetchEverything(EveryThingParams(page: 0, q: 'a')),
          throwsAssertionError);
    });
    test('fetch headlines should be failed because q is invalid', () async {
      expect(
          () async => await dataSource
              .fetchEverything(EveryThingParams(page: 1, q: '   ')),
          throwsAssertionError);
    });
    test('fetch headlines should be failed because qInTitle is invalid',
        () async {
      expect(
          () async => await dataSource
              .fetchEverything(EveryThingParams(page: 1, qInTitle: '   ')),
          throwsAssertionError);
    });
    test('fetch headlines should be failed because sources is invalid',
        () async {
      expect(
          () async => await dataSource
              .fetchEverything(EveryThingParams(page: 1, sources: '   ')),
          throwsAssertionError);
    });
    test('fetch headlines should be failed because domains is invalid',
        () async {
      expect(
          () async => await dataSource
              .fetchEverything(EveryThingParams(page: 1, domains: '   ')),
          throwsAssertionError);
    });
  });
}
