import 'package:flutter/material.dart';

import 'package:newsapi_flutter/src/view/widgets/article_list_widget.dart';
import 'package:newsapi_flutter/src/view_model/providers/top_headlines_provider.dart';

class TopHeadlinesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(children: [
                Text('Top Headlines',
                    style: Theme.of(context).textTheme.headline5)
              ]),
            ),
            Expanded(child: ArticleListWidget(provider: topHeadlinesProvider))
          ],
        ),
      ),
    );
  }
}
