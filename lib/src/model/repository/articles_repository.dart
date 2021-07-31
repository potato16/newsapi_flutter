import 'package:dartz/dartz.dart';

import 'package:newsapi_flutter/src/core/error/exceptions.dart';
import 'package:newsapi_flutter/src/core/error/failures.dart';
import 'package:newsapi_flutter/src/model/data_sources/articles_remote_data_source.dart';
import 'package:newsapi_flutter/src/model/models/article.dart';
import 'package:newsapi_flutter/src/model/models/everything_param.dart';
import 'package:newsapi_flutter/src/model/models/headlines_param.dart';

abstract class ArticlesRepository {
  /// Get top headlines news
  Future<Either<Failure, List<Article>>> getTopHeadlines({required int page});

  /// Get custom news from api /everything
  Future<Either<Failure, List<Article>>> getEverything({
    required int page,
    required String query,
  });
}

const int _pageSize = 30;

class ArticlesRepositoryImpl extends ArticlesRepository {
  ArticlesRepositoryImpl({required this.remoteDataSource});
  final ArticlesRemoteDataSource remoteDataSource;
  @override
  Future<Either<Failure, List<Article>>> getEverything(
      {required int page, required String query}) async {
    assert(page > 0, 'The page parameter cannot be less than 1.');
    try {
      final params = EveryThingParams(pageSize: _pageSize, q: query);
      final result = await remoteDataSource.fetchEverything(params);
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

  @override
  Future<Either<Failure, List<Article>>> getTopHeadlines(
      {required int page}) async {
    assert(page > 0, 'The page parameter cannot be less than 1.');
    try {
      final params = HeadLinesParams(pageSize: _pageSize);
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
