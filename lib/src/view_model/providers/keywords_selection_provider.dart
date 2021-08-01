import 'package:flutter_riverpod/flutter_riverpod.dart';

final keywordsProvider =
    Provider((ref) => ['covid', 'bitcoin', 'apple', 'earthquake', 'animal']);
final currentKeywordProvider =
    StateNotifierProvider<CurrentKeywordStateNotifier, String>((ref) {
  final keywords = ref.watch(keywordsProvider);
  return CurrentKeywordStateNotifier(keywords.first, keywords: keywords);
});

class CurrentKeywordStateNotifier extends StateNotifier<String> {
  CurrentKeywordStateNotifier(String state, {required this.keywords})
      : super(state);
  final List<String> keywords;
  void select(String keyword) {
    if (keywords.contains(keyword)) {
      state = keyword;
    }
  }
}
