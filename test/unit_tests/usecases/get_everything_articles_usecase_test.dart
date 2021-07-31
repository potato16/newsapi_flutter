import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:newsapi_flutter/src/core/error/failures.dart';
import 'package:newsapi_flutter/src/model/models/everything_param.dart';
import 'package:newsapi_flutter/src/model/repository/articles_repository.dart';
import 'package:newsapi_flutter/src/view_model/usecases/get_everything_articles_usecase.dart';

import 'get_everything_articles_usecase_test.mocks.dart';

@GenerateMocks([ArticlesRepository])
void main() {
  late MockArticlesRepository mockArticlesRepository;
  late GetEverythingUseCase usecase;
  setUp(() {
    mockArticlesRepository = MockArticlesRepository();
    usecase = GetEverythingUseCase(mockArticlesRepository);
  });

  test('get everything articles should be success', () async {
    when(mockArticlesRepository.getEverything(any))
        .thenAnswer((_) async => Right([]));
    final result = await usecase.call(EveryThingParams(page: 1, q: 'a'));
    expect(result.isRight(), isTrue);
  });
  test('get everything articles should be failed', () async {
    when(mockArticlesRepository.getEverything(any))
        .thenAnswer((_) async => Left(ServerFailure()));
    final result = await usecase.call(EveryThingParams(page: 1, q: 'a'));
    expect(result.isLeft(), isTrue);
  });
}
