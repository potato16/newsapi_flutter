import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:newsapi_flutter/src/core/usecases/usecase.dart';
import 'package:newsapi_flutter/src/model/models/user_preferences.dart';
import 'package:newsapi_flutter/src/view_model/di.dart';
import 'package:newsapi_flutter/src/view_model/usecases/get_user_preferences_usecase.dart';
import 'package:newsapi_flutter/src/view_model/usecases/save_user_preferences_usecase.dart';

final userPreferencesProvider =
    StateNotifierProvider<UserPreferencesStateNotifier, UserPreferences>((ref) {
  final getUseCase = ref.watch(getUserPreferencesUseCaseProvider);
  final saveUseCase = ref.watch(saveUserPreferencesUseCaseProvider);
  final instance = UserPreferencesStateNotifier(
    UserPreferences(country: 'gb', language: 'en'),
    getUseCase: getUseCase,
    saveUseCase: saveUseCase,
    reader: ref.read,
  );
  instance.fetch();
  return instance;
});

class UserPreferencesStateNotifier extends StateNotifier<UserPreferences> {
  UserPreferencesStateNotifier(UserPreferences state,
      {required this.getUseCase,
      required this.saveUseCase,
      required this.reader})
      : super(state);
  final GetUserPreferencesUseCase getUseCase;
  final SaveUserPreferencesUseCase saveUseCase;
  final Reader reader;
  Future<void> fetch() async {
    final result = await getUseCase.call(NoParams());
    final value = result.fold((l) {
      reader(messageProvider).state = l.message;
    }, (r) => r);
    if (value != null) {
      state = value;
    }
  }

  void updateUsername(String username) {
    final userPref = state.copyWidth(name: username);
    _save(userPref);
  }

  void _save(UserPreferences userPreferences) {
    saveUseCase.call(userPreferences);
    state = userPreferences;
  }

  void updateLanguage(String language) {
    final userPref = state.copyWidth(language: language);
    _save(userPref);
  }

  void updateCountry(String country) {
    final userPref = state.copyWidth(country: country);
    _save(userPref);
  }
}
