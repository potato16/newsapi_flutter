import 'package:dartz/dartz.dart';

import 'package:newsapi_flutter/src/core/error/exceptions.dart';
import 'package:newsapi_flutter/src/core/error/failures.dart';
import 'package:newsapi_flutter/src/model/data_sources/articles_remote_data_source.dart';
import 'package:newsapi_flutter/src/model/models/article.dart';
import 'package:newsapi_flutter/src/model/models/everything_param.dart';
import 'package:newsapi_flutter/src/model/models/headlines_param.dart';

abstract class ArticlesRepository {
  /// Get top headlines news
  Future<Either<Failure, List<Article>>> getTopHeadlines(
      HeadLinesParams params);

  /// Get custom news from api /everything
  Future<Either<Failure, List<Article>>> getEverything(EveryThingParams params);
}

class ArticlesRepositoryImpl extends ArticlesRepository {
  ArticlesRepositoryImpl({required this.remoteDataSource});
  final ArticlesRemoteDataSource remoteDataSource;
  @override
  Future<Either<Failure, List<Article>>> getEverything(
      EveryThingParams params) async {
    try {
      final result = await remoteDataSource.fetchEverything(params);
      return Right(result.articles);
    } on ServerException catch (e) {
      print('here');
      return Left(ServerFailure(
        code: e.code,
        status: e.status,
        message: e.message,
      ));
    } catch (e) {
      print('nohere');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getTopHeadlines(
      HeadLinesParams params) async {
    try {
      final result = await remoteDataSource.fetchHeadlines(params);
      return Right(result.articles);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        code: e.code,
        status: e.status,
        message: e.message,
      ));
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
