import 'package:dartz/dartz.dart';

import 'package:newsapi_flutter/src/core/error/exceptions.dart';
import 'package:newsapi_flutter/src/core/error/failures.dart';
import 'package:newsapi_flutter/src/model/data_sources/user_preferences_local_data_source.dart';
import 'package:newsapi_flutter/src/model/models/user_preferences.dart';

abstract class UserPreferencesRepository {
  Future<Either<Failure, UserPreferences>> getUserPref();

  Future<Either<Failure, void>> saveUserPref(UserPreferences userPreferences);
}

class UserPreferencesRepositoryImpl extends UserPreferencesRepository {
  UserPreferencesRepositoryImpl({required this.localDataSource});
  final UserPrefLocalDataSource localDataSource;
  @override
  Future<Either<Failure, UserPreferences>> getUserPref() async {
    try {
      final value = await localDataSource.fetch();
      return Right(value);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveUserPref(
      UserPreferences userPreferences) async {
    try {
      final value = await localDataSource.save(userPreferences);
      return Right(value);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
