// Mocks generated by Mockito 5.0.13 from annotations
// in newsapi_flutter/test/widget_test/customize_news_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:newsapi_flutter/src/core/error/failures.dart' as _i6;
import 'package:newsapi_flutter/src/model/models/article.dart' as _i7;
import 'package:newsapi_flutter/src/model/models/everything_param.dart' as _i8;
import 'package:newsapi_flutter/src/model/repository/articles_repository.dart'
    as _i2;
import 'package:newsapi_flutter/src/view_model/usecases/get_everything_articles_usecase.dart'
    as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeArticlesRepository extends _i1.Fake
    implements _i2.ArticlesRepository {}

class _FakeEither<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetEverythingUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetEverythingUseCase extends _i1.Mock
    implements _i4.GetEverythingUseCase {
  MockGetEverythingUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ArticlesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeArticlesRepository()) as _i2.ArticlesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Article>>> call(
          _i8.EveryThingParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.Article>>>.value(
              _FakeEither<_i6.Failure, List<_i7.Article>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.Article>>>);
  @override
  String toString() => super.toString();
}