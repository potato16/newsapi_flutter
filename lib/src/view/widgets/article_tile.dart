import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:newsapi_flutter/src/core/util/asset_path.dart';
import 'package:newsapi_flutter/src/model/models/article.dart';

class ArticleTile extends StatelessWidget {
  ArticleTile({Key? key, required this.data}) : super(key: key);
  final Article data;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: FadeInImage.assetNetwork(
              key: ValueKey('article_image_${data.urlToImage}'),
              fit: BoxFit.cover,
              image: data.urlToImage,
              placeholder: AssetPath.imgEmpty,
              imageErrorBuilder: (_, __, ___) => Image.asset(
                AssetPath.imgEmpty,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(data.title,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              SizedBox(height: 18),
              Flexible(
                child: Text(
                  data.description,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
