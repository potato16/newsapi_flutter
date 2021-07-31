import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:newsapi_flutter/src/core/error/failures.dart';
import 'package:newsapi_flutter/src/model/models/headlines_param.dart';
import 'package:newsapi_flutter/src/view_model/usecases/get_top_headlines_usecase.dart';

import 'get_everything_articles_usecase_test.mocks.dart';

void main() {
  late MockArticlesRepository mockArticlesRepository;
  late GetTopHeadlinesUseCase usecase;
  setUp(() {
    mockArticlesRepository = MockArticlesRepository();
    usecase = GetTopHeadlinesUseCase(mockArticlesRepository);
  });

  test('get headlines articles should be success', () async {
    when(mockArticlesRepository.getTopHeadlines(any))
        .thenAnswer((_) async => Right([]));
    final result = await usecase.call(HeadLinesParams(page: 1));
    expect(result.isRight(), isTrue);
  });
  test('get headlines articles should be failed', () async {
    when(mockArticlesRepository.getTopHeadlines(any))
        .thenAnswer((_) async => Left(ServerFailure()));
    final result = await usecase.call(HeadLinesParams(page: 1));
    expect(result.isLeft(), isTrue);
  });
}
