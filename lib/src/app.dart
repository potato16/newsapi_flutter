import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:newsapi_flutter/src/core/navigation/route_information_parser.dart';
import 'package:newsapi_flutter/src/core/navigation/router_delegate.dart';
import 'package:newsapi_flutter/src/core/util/theme_provider.dart';
import 'package:newsapi_flutter/src/view_model/di.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> _initSharePref() async {
    final sharePref = await SharedPreferences.getInstance();
    context.read(sharedPreferencesProvider).state = sharePref;
  }

  @override
  Widget build(BuildContext context) {
    final routeDelegate = context.read(seedRouterDelegateProvider);
    return FutureBuilder(
        future: _initSharePref(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp.router(
              routeInformationParser:
                  context.read(routeInformationParserProvider),
              theme: context.read(themeProvider),
              routerDelegate: routeDelegate,
              backButtonDispatcher:
                  context.read(backButtonDispatcherProvider(routeDelegate)),
            );
          }
          return CircularProgressIndicator.adaptive();
        });
  }
}
