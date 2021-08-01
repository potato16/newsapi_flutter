import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:newsapi_flutter/src/core/util/theme_provider.dart';
import 'package:newsapi_flutter/src/view/widgets/article_list_widget.dart';
import 'package:newsapi_flutter/src/view_model/providers/customize_news_provider.dart';
import 'package:newsapi_flutter/src/view_model/providers/keywords_selection_provider.dart';

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
            Expanded(child: ArticleListWidget(provider: customizeNewsProvider))
          ],
        ),
      ),
    );
  }
}
