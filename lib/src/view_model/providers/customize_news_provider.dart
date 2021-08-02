import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:newsapi_flutter/src/model/models/article.dart';
import 'package:newsapi_flutter/src/model/models/everything_param.dart';
import 'package:newsapi_flutter/src/model/models/user_preferences.dart';
import 'package:newsapi_flutter/src/view_model/di.dart';
import 'package:newsapi_flutter/src/view_model/providers/keywords_selection_provider.dart';
import 'package:newsapi_flutter/src/view_model/providers/user_preferences_provider.dart';
import 'package:newsapi_flutter/src/view_model/usecases/get_everything_articles_usecase.dart';

final customizeNewsProvider = StateNotifierProvider.autoDispose<
    CustomizeNewsStateNotifier, PagingController<int, Article>>((ref) {
  final keyword = ref.watch(currentKeywordProvider);
  final UserPreferences userPreferences = ref.watch(userPreferencesProvider);
  final PagingController<int, Article> pagingController =
      PagingController(firstPageKey: 1);
  final instance = CustomizeNewsStateNotifier(pagingController,
      getUseCase: ref.read(getEverythingUseCaseProvider),
      keyword: keyword,
      reader: ref.read,
      userPreferences: userPreferences);
  pagingController.addPageRequestListener((pageKey) {
    instance.fetch();
  });
  instance.fetch();
  return instance;
});

class CustomizeNewsStateNotifier
    extends StateNotifier<PagingController<int, Article>> {
  CustomizeNewsStateNotifier(
    PagingController<int, Article> state, {
    required this.userPreferences,
    required this.getUseCase,
    required this.keyword,
    required this.reader,
  }) : super(state);
  final GetEverythingUseCase getUseCase;
  final UserPreferences userPreferences;
  final String keyword;
  final Reader reader;
  final int _pageSize = 20;

  Future<void> fetch() async {
    final params = EveryThingParams(
      page: state.nextPageKey ?? 1,
      pageSize: _pageSize,
      language: userPreferences.language,
      q: keyword,
    );

    final result = await getUseCase.call(params);
    final List<Article>? newItems = result.fold((l) {
      reader(messageProvider).state = l.message;
      print(l.message);
      state.error = l.message ?? '';
      return;
    }, (r) => r);
    //ignore duplicate request
    if (params.page < (state.nextPageKey ?? 1)) {
      return;
    }
    if (newItems != null) {
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        state.appendLastPage(newItems);
      } else {
        final nextPageKey = (state.nextPageKey ?? 1) + 1;
        state.appendPage(newItems, nextPageKey);
      }
    }
  }
}
