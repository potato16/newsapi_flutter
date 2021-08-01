import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:newsapi_flutter/src/model/models/article.dart';
import 'package:newsapi_flutter/src/model/models/everything_param.dart';
import 'package:newsapi_flutter/src/view_model/di.dart';
import 'package:newsapi_flutter/src/view_model/usecases/get_everything_articles_usecase.dart';

class CustomizeNewsStateNotifier extends StateNotifier<List<Article>> {
  CustomizeNewsStateNotifier(List<Article> state,
      {required this.getArticlesUseCase, required this.reader})
      : super(state);
  final GetEverythingUseCase getArticlesUseCase;
  final Reader reader;

  Future<void> fetch() async {
    print('a');
    try {
      final result =
          await getArticlesUseCase.call(EveryThingParams(page: 1, q: 'covid'));
      final value = result.fold((l) {
        print('b');
        reader(messageProvider).state = l.message;
        print(l.message);
        return;
      }, (r) => r);
      print('c');
      if (value != null) {
        state = value;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
}
