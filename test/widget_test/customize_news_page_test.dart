import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:newsapi_flutter/src/core/error/failures.dart';
import 'package:newsapi_flutter/src/model/models/article.dart';
import 'package:newsapi_flutter/src/model/models/articles_response.dart';
import 'package:newsapi_flutter/src/view/pages/customize_news_page.dart';
import 'package:newsapi_flutter/src/view/widgets/article_tile.dart';
import 'package:newsapi_flutter/src/view/widgets/empty_widget.dart';
import 'package:newsapi_flutter/src/view_model/di.dart';
import 'package:newsapi_flutter/src/view_model/usecases/get_everything_articles_usecase.dart';

import '../fixtures/fixture_reader.dart';
import 'customize_news_page_test.mocks.dart';

@GenerateMocks([GetEverythingUseCase])
void main() {
  late MockGetEverythingUseCase mockGetEverythingUseCase;
  final List<Article> articles =
      ArticlesResponse.fromJson(json.decode(fixture('articles.json'))).articles;
  setUp(() {
    mockGetEverythingUseCase = MockGetEverythingUseCase();
  });
  testWidgets('CustomizeNewsPage should show list articles success',
      (tester) async {
    when(mockGetEverythingUseCase.call(any))
        .thenAnswer((_) async => Right(articles));
    await mockNetworkImagesFor(() => tester.pumpWidget(ProviderScope(
            overrides: [
              getEverythingUseCaseProvider
                  .overrideWithValue(mockGetEverythingUseCase)
            ],
            child: MaterialApp(home: CustomizeNewsPage()))));

    /// Loading state
    expect(find.byKey(ValueKey(firstPageIndicatorKey)), findsOneWidget);
    expect(find.byKey(ValueKey(pageIndicatorKey)), findsNothing);
    await mockNetworkImagesFor(() => tester.pump());

    ///  Get response success
    expect(find.byKey(ValueKey(articleListViewKey)), findsOneWidget);
    expect(find.byKey(ValueKey(pageIndicatorKey)), findsNothing);
    expect(find.byType(ArticleTile), findsWidgets);
  });
  testWidgets(
      'CustomizeNewsPage should show empty widget because failed to get data',
      (tester) async {
    when(mockGetEverythingUseCase.call(any))
        .thenAnswer((_) async => Left(ServerFailure()));
    await mockNetworkImagesFor(() => tester.pumpWidget(ProviderScope(
            overrides: [
              getEverythingUseCaseProvider
                  .overrideWithValue(mockGetEverythingUseCase)
            ],
            child: MaterialApp(home: CustomizeNewsPage()))));
    expect(find.byKey(ValueKey(firstPageIndicatorKey)), findsOneWidget);
    await mockNetworkImagesFor(() => tester.pump());
    expect(find.byKey(ValueKey(articleListViewKey)), findsOneWidget);
    expect(find.byKey(ValueKey(pageIndicatorKey)), findsNothing);
    expect(find.byType(ArticleTile), findsNothing);
    expect(find.byType(EmptyWidget), findsOneWidget);
  });
  testWidgets(
      'CustomizeNewsPage should show empty widget because no items found',
      (tester) async {
    when(mockGetEverythingUseCase.call(any)).thenAnswer((_) async => Right([]));
    await mockNetworkImagesFor(() => tester.pumpWidget(ProviderScope(
            overrides: [
              getEverythingUseCaseProvider
                  .overrideWithValue(mockGetEverythingUseCase)
            ],
            child: MaterialApp(home: CustomizeNewsPage()))));
    expect(find.byKey(ValueKey(firstPageIndicatorKey)), findsOneWidget);
    await mockNetworkImagesFor(() => tester.pump());
    expect(find.byKey(ValueKey(articleListViewKey)), findsOneWidget);
    expect(find.byKey(ValueKey(pageIndicatorKey)), findsNothing);
    expect(find.byType(ArticleTile), findsNothing);
    expect(find.byType(EmptyWidget), findsOneWidget);
  });
  testWidgets('CustomizeNewsPage should update after change keyword',
      (tester) async {
    when(mockGetEverythingUseCase.call(any))
        .thenAnswer((_) async => Right(articles));
    await mockNetworkImagesFor(() => tester.pumpWidget(ProviderScope(
            overrides: [
              getEverythingUseCaseProvider
                  .overrideWithValue(mockGetEverythingUseCase)
            ],
            child: MaterialApp(home: CustomizeNewsPage()))));
    expect(find.byKey(ValueKey(firstPageIndicatorKey)), findsOneWidget);
    expect(find.byKey(ValueKey(pageIndicatorKey)), findsNothing);
    expect(find.byKey(ValueKey(articleListViewKey)), findsOneWidget);
    await mockNetworkImagesFor(() => tester.pump());
    expect(find.byKey(ValueKey(pageIndicatorKey)), findsNothing);
    expect(find.byType(ArticleTile), findsWidgets);
    final keywordOneFinder = find.byKey(ValueKey('keyword:1'));
    expect(keywordOneFinder, findsOneWidget);
    await mockNetworkImagesFor(() => tester.tap(keywordOneFinder));
    when(mockGetEverythingUseCase.call(any))
        .thenAnswer((_) async => Left(ServerFailure()));
    await mockNetworkImagesFor(() => tester.pump());
    expect(find.byType(ArticleTile), findsNothing);
    expect(find.byKey(ValueKey(firstPageIndicatorKey)), findsOneWidget);
    await mockNetworkImagesFor(() => tester.pumpAndSettle());
    expect(find.byType(EmptyWidget), findsOneWidget);
  });
}
