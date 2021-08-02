import 'package:dartz/dartz.dart';

import 'package:newsapi_flutter/src/core/error/failures.dart';
import 'package:newsapi_flutter/src/core/usecases/usecase.dart';
import 'package:newsapi_flutter/src/model/models/user_preferences.dart';
import 'package:newsapi_flutter/src/model/repository/user_pref_repository.dart';

class GetUserPreferencesUseCase implements UseCase<UserPreferences, NoParams> {
  GetUserPreferencesUseCase(this.repository);
  final UserPreferencesRepository repository;
  @override
  Future<Either<Failure, UserPreferences>> call(NoParams params) {
    return repository.getUserPref();
  }
}
