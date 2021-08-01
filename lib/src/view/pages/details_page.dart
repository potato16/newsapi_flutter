import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:newsapi_flutter/src/core/util/asset_path.dart';
import 'package:newsapi_flutter/src/core/util/helpers.dart';
import 'package:newsapi_flutter/src/model/models/article.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({required this.data});
  // title of the article, use to get article details
  final Article data;
  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: TextButton.icon(
        icon: SvgPicture.asset(AssetPath.icOut,
            fit: BoxFit.contain, height: 16, width: 16),
        label: Text('Source: ${data.source.name}',
            style: TextStyle(color: Colors.black)),
        onPressed: () {
          _launchURL(data.url);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                child: FadeInImage.assetNetwork(
                  key: ValueKey('article_image_${data.urlToImage}'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 160,
                  image: data.urlToImage,
                  placeholder: AssetPath.imgEmpty,
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
                data.content.length > maxContentLength
                    ? data.content.substring(0, maxContentLength)
                    : data.content,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
