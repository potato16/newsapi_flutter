import 'package:dartz/dartz.dart';

import 'package:newsapi_flutter/src/core/error/failures.dart';
import 'package:newsapi_flutter/src/core/usecases/usecase.dart';
import 'package:newsapi_flutter/src/model/models/article.dart';
import 'package:newsapi_flutter/src/model/models/headlines_param.dart';
import 'package:newsapi_flutter/src/model/repository/articles_repository.dart';

class GetTopHeadlinesUseCase
    implements UseCase<List<Article>, HeadLinesParams> {
  GetTopHeadlinesUseCase(this.repository);
  final ArticlesRepository repository;
  @override
  Future<Either<Failure, List<Article>>> call(HeadLinesParams params) {
    return repository.getTopHeadlines(params);
  }
}
