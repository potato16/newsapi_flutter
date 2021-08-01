import 'package:flutter/material.dart';

import 'package:newsapi_flutter/src/core/util/asset_path.dart';
import 'package:newsapi_flutter/src/core/util/helpers.dart';
import 'package:newsapi_flutter/src/model/models/article.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({required this.data});
  // title of the article, use to get article details
  final Article data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        key: ValueKey('details'),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.chevron_left)),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: FadeInImage.assetNetwork(
                    key: ValueKey('article_image_${data.urlToImage}'),
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                    image: data.urlToImage,
                    placeholder: AssetPath.imgEmpty,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                data.title,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Text(
                    convertDateTimeFormat(data.publishedAt),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Container(height: 1, width: 16),
                  Text(
                    data.author,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ]),
              ),
              SizedBox(height: 40),
              Text(
                data.content,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
