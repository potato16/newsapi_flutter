import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:newsapi_flutter/src/model/models/article.dart';
import 'package:newsapi_flutter/src/model/models/articles_response.dart';
import 'package:newsapi_flutter/src/view/pages/details_page.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  final List<Article> articles =
      ArticlesResponse.fromJson(json.decode(fixture('articles.json'))).articles;
  for (final article in articles) {
    group('DetailsPage with article:$article', () {
      testWidgets('$DetailsPage should show full details of article',
          (WidgetTester tester) async {
        await mockNetworkImagesFor(() =>
            tester.pumpWidget(MaterialApp(home: DetailsPage(data: article))));
        await mockNetworkImagesFor(() => tester.pump());
        final dataFinder = find.byKey(ValueKey('details'));
        expect(dataFinder, findsOneWidget);
      });
      testWidgets('$DetailsPage tap to source link',
          (WidgetTester tester) async {
        await mockNetworkImagesFor(() =>
            tester.pumpWidget(MaterialApp(home: DetailsPage(data: article))));
        await mockNetworkImagesFor(() => tester.pump());
        final dataFinder = find.byKey(ValueKey('details'));
        expect(dataFinder, findsOneWidget);
        final sourceButtonFinder = find.byKey(ValueKey(sourceButtonKey));
        await tester.tap(sourceButtonFinder);

        /// We expect fail to handle url_launcher
        expect(find.byKey(ValueKey('details')), findsOneWidget);
      });
    });
  }
}
