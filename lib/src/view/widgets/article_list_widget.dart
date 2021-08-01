import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:newsapi_flutter/src/core/navigation/route_information_parser.dart';
import 'package:newsapi_flutter/src/core/navigation/router_delegate.dart';
import 'package:newsapi_flutter/src/model/models/article.dart';
import 'package:newsapi_flutter/src/view/widgets/article_tile.dart';
import 'package:newsapi_flutter/src/view/widgets/empty_widget.dart';

const String articleListViewKey = 'articleListViewKey';
const String firstPageIndicatorKey = 'articles.firstPageIndicatorKey';
const String pageIndicatorKey = 'articles.pageIndicatorKey';

class ArticleListWidget extends StatelessWidget {
  const ArticleListWidget({
    Key? key,
    required this.provider,
  }) : super(key: key);
  final ProviderBase<Object?, PagingController<int, Article>> provider;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final PagingController<int, Article> _pagingController = watch(provider);
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
