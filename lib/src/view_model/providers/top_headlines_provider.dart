import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:newsapi_flutter/src/model/models/article.dart';
import 'package:newsapi_flutter/src/model/models/headlines_param.dart';
import 'package:newsapi_flutter/src/view_model/di.dart';
import 'package:newsapi_flutter/src/view_model/usecases/get_top_headlines_usecase.dart';

final topHeadlinesProvider = StateNotifierProvider<TopHeadlinesStateNotifier,
    PagingController<int, Article>>((ref) {
  final PagingController<int, Article> pagingController =
      PagingController(firstPageKey: 1);
  final instance = TopHeadlinesStateNotifier(pagingController,
      getUseCase: ref.read(getTopHeadlinesUseCaseProvider), reader: ref.read);
  pagingController.addPageRequestListener((pageKey) {
    instance.fetch();
  });
  instance.fetch();
  return instance;
});

class TopHeadlinesStateNotifier
    extends StateNotifier<PagingController<int, Article>> {
  TopHeadlinesStateNotifier(
    PagingController<int, Article> state, {
    required this.getUseCase,
    required this.reader,
  }) : super(state);
  final GetTopHeadlinesUseCase getUseCase;
  final Reader reader;
  final int _pageSize = 20;

  Future<void> fetch() async {
    final params = HeadLinesParams(
      page: state.nextPageKey ?? 1,
      pageSize: _pageSize,
      country: 'gb',
    );

    final result = await getUseCase.call(params);
    final List<Article>? newItems = result.fold((l) {
      reader(messageProvider).state = l.message;
      print('get top headlines error: ${l.message}');
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
