import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:newsapi_flutter/src/core/navigation/route_information_parser.dart';
import 'package:newsapi_flutter/src/core/navigation/router_delegate.dart';
import 'package:newsapi_flutter/src/model/models/article.dart';
import 'package:newsapi_flutter/src/view/widgets/article_tile.dart';
import 'package:newsapi_flutter/src/view/widgets/empty_widget.dart';
import 'package:newsapi_flutter/src/view_model/di.dart';

class CustomizeNewsPage extends StatefulWidget {
  @override
  _CustomizeNewsPageState createState() => _CustomizeNewsPageState();
}

class _CustomizeNewsPageState extends State<CustomizeNewsPage> {
  //Load one time when init widget
  late Future loadData = context.read(customizeNewsProvider.notifier).fetch();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: loadData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer(builder: (context, watch, child) {
                  final List<Article> articles = watch(customizeNewsProvider);
                  if (articles.isEmpty) {
                    return EmptyWidget(key: ValueKey('articles_empty'));
                  }
                  return ListView.builder(
                    key: const ValueKey('articles_listview'),
                    shrinkWrap: true,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final item = articles.elementAt(index);
                      return GestureDetector(
                          onTap: () {
                            context
                                .read(seedRouterDelegateProvider)
                                .setNewRoutePath(PageConfiguration(
                                    path: SeedPath.details, state: item));
                          },
                          child: ArticleTile(
                            data: item,
                            key: ValueKey('article_tile_$index'),
                          ));
                    },
                  );
                });
              }
              return Center(
                child: CircularProgressIndicator.adaptive(
                    key: ValueKey('articles_loadingview')),
              );
            }),
      ),
    );
  }
}
