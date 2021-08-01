import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:newsapi_flutter/src/model/models/article.dart';
import 'package:newsapi_flutter/src/model/models/everything_param.dart';
import 'package:newsapi_flutter/src/view_model/di.dart';
import 'package:newsapi_flutter/src/view_model/providers/keywords_selection_provider.dart';
import 'package:newsapi_flutter/src/view_model/usecases/get_everything_articles_usecase.dart';

final customizeNewsProvider =
    StateNotifierProvider<CustomizeNewsStateNotifier, List<Article>?>((ref) {
  final keyword = ref.watch(currentKeywordProvider);
  final instance = CustomizeNewsStateNotifier(null,
      getUseCase: ref.read(getEverythingUseCaseProvider),
      keyword: keyword,
      reader: ref.read);
  instance.fetch();
  return instance;
});

class CustomizeNewsStateNotifier extends StateNotifier<List<Article>?> {
  CustomizeNewsStateNotifier(
    List<Article>? state, {
    required this.getUseCase,
    required this.keyword,
    required this.reader,
  }) : super(state);
  final GetEverythingUseCase getUseCase;
  final String keyword;
  final Reader reader;

  Future<void> fetch() async {
    print('a');
    final params = EveryThingParams(page: 1, q: keyword);
    print('b');

    final result = await getUseCase.call(params);
    final value = result.fold((l) {
      reader(messageProvider).state = l.message;
      print(l.message);
      return;
    }, (r) => r);
    if (value != null) {
      state = value;
    }
  }
}
