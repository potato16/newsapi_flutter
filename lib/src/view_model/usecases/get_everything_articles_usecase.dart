import 'package:dartz/dartz.dart';

import 'package:newsapi_flutter/src/core/error/failures.dart';
import 'package:newsapi_flutter/src/core/usecases/usecase.dart';
import 'package:newsapi_flutter/src/model/models/article.dart';
import 'package:newsapi_flutter/src/model/models/everything_param.dart';
import 'package:newsapi_flutter/src/model/repository/articles_repository.dart';

class GetEverythingUseCase implements UseCase<List<Article>, EveryThingParams> {
  GetEverythingUseCase(this.repository);
  final ArticlesRepository repository;
  @override
  Future<Either<Failure, List<Article>>> call(EveryThingParams params) {
    return repository.getEverything(params);
  }
}
