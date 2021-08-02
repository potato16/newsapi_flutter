import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:newsapi_flutter/src/core/util/asset_path.dart';
import 'package:newsapi_flutter/src/core/util/theme_provider.dart';
import 'package:newsapi_flutter/src/view_model/providers/user_preferences_provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, String> languages = {
    'en': 'English',
    'vi': 'Tiếng Việt',
    'id': 'Bahasa Indonesia',
    'zh': '中文',
  };
  Map<String, String> countries = {
    'gb': 'United Kingdom',
    'vn': 'Viet Nam',
    'id': 'Indonesia',
    'tw': 'Taiwan',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Setting', style: Theme.of(context).textTheme.headline5),
                SizedBox(height: 16),
                ListTile(
                    tileColor: AppColor.hintBackground,
                    leading: Icon(Icons.settings),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    title: Text('Custom your news feed'),
                    subtitle: Text('Make a news page just for you')),
                SizedBox(height: 16),
                TextField(
                    decoration: InputDecoration(hintText: 'Enter your name...'),
                    onSubmitted: (value) {
                      context
                          .read(userPreferencesProvider.notifier)
                          .updateUsername(value);
                    }),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                          tileColor: AppColor.active,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          leading: SvgPicture.asset(AssetPath.icFilter),
                          title: Text('Language'),
                          subtitle: Consumer(builder: (context, watch, child) {
                            final value =
                                watch(userPreferencesProvider).language;
                            return Text(languages[value] ?? '');
                          }),
                          onTap: () {
                            buildShowModalBottomSheet(context, languages)
                                .then((value) {
                              if (value is String) {
                                context
                                    .read(userPreferencesProvider.notifier)
                                    .updateLanguage(value);
                              }
                            });
                          }),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ListTile(
                          tileColor: AppColor.active,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          leading: SvgPicture.asset(AssetPath.icFilter),
                          title: Text('Country'),
                          subtitle: Consumer(builder: (context, watch, child) {
                            final country =
                                watch(userPreferencesProvider).country;
                            return Text(countries[country] ?? '');
                          }),
                          onTap: () {
                            buildShowModalBottomSheet(context, countries)
                                .then((value) {
                              if (value is String) {
                                context
                                    .read(userPreferencesProvider.notifier)
                                    .updateCountry(value);
                              }
                            });
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> buildShowModalBottomSheet(
      BuildContext context, Map<String, String> options) {
    return showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: options.keys.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    onTap: () {
                      Navigator.pop(context, options.keys.elementAt(index));
                    },
                    title: Text(
                      options.values.elementAt(index),
                    ),
                    subtitle: Text(
                      options.keys.elementAt(index),
                    ));
              },
            ),
          ),
        );
      },
    );
  }
}
