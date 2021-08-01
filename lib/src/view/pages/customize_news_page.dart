import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:newsapi_flutter/src/core/navigation/route_information_parser.dart';
import 'package:newsapi_flutter/src/core/navigation/router_delegate.dart';
import 'package:newsapi_flutter/src/core/util/theme_provider.dart';
import 'package:newsapi_flutter/src/model/models/article.dart';
import 'package:newsapi_flutter/src/view/widgets/article_tile.dart';
import 'package:newsapi_flutter/src/view/widgets/empty_widget.dart';
import 'package:newsapi_flutter/src/view_model/providers/customize_news_provider.dart';
import 'package:newsapi_flutter/src/view_model/providers/keywords_selection_provider.dart';

const String articleListViewKey = 'custom.articleListViewKey';
const String firstPageIndicatorKey = 'custom.firstPageIndicatorKey';
const String pageIndicatorKey = 'custom.pageIndicatorKey';

class CustomizeNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Consumer(builder: (context, watch, child) {
              final List<String> keywords = watch(keywordsProvider);
              final String currentKeyword = watch(currentKeywordProvider);
              return SizedBox(
                height: 56,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 18);
                  },
                  itemCount: keywords.length,
                  itemBuilder: (BuildContext context, int index) {
                    final keyword = keywords.elementAt(index);
                    return GestureDetector(
                      key: ValueKey('keyword:$index'),
                      onTap: () {
                        context
                            .read(currentKeywordProvider.notifier)
                            .select(keyword);
                      },
                      child: Chip(
                        backgroundColor: keyword == currentKeyword
                            ? AppColor.secondColor
                            : Colors.white,
                        label: Text(keyword),
                        labelStyle: Theme.of(context).textTheme.caption,
                      ),
                    );
                  },
                ),
              );
            }),
            Expanded(child: _CustomNewsContentWidget())
          ],
        ),
      ),
    );
  }
}

class _CustomNewsContentWidget extends StatelessWidget {
  const _CustomNewsContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final PagingController<int, Article> _pagingController =
          watch(customizeNewsProvider);
      return PagedListView<int, Article>(
        key: const ValueKey(articleListViewKey),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Article>(
          firstPageErrorIndicatorBuilder: (_) => EmptyWidget(),
          noItemsFoundIndicatorBuilder: (_) => EmptyWidget(),
          firstPageProgressIndicatorBuilder: (_) =>
              CircularProgressIndicator.adaptive(
                  key: const ValueKey(firstPageIndicatorKey)),
          newPageProgressIndicatorBuilder: (_) =>
              CircularProgressIndicator.adaptive(
                  key: const ValueKey(pageIndicatorKey)),
          itemBuilder: (context, item, index) {
            return GestureDetector(
                onTap: () {
                  context.read(seedRouterDelegateProvider).setNewRoutePath(
                      PageConfiguration(path: SeedPath.details, state: item));
                },
                child: ArticleTile(
                  data: item,
                  key: ValueKey('article_tile_$index'),
                ));
          },
        ),
      );
    });
  }
}
