import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:newsapi_flutter/src/core/navigation/route_information_parser.dart';
import 'package:newsapi_flutter/src/core/navigation/router_delegate.dart';
import 'package:newsapi_flutter/src/core/util/theme_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeDelegate = context.read(seedRouterDelegateProvider);
    return MaterialApp.router(
      routeInformationParser: context.read(routeInformationParserProvider),
      theme: context.read(themeProvider),
      routerDelegate: routeDelegate,
      backButtonDispatcher:
          context.read(backButtonDispatcherProvider(routeDelegate)),
    );
  }
}
