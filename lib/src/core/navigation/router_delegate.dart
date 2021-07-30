import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'route_information_parser.dart';

final seedRouterDelegateProvider = Provider((ref) => SeedRouterDelegate());
final backButtonDispatcherProvider = Provider.family(
    (ref, SeedRouterDelegate delegate) => AppBackButtonDispatcher(delegate));

class SeedRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  SeedRouterDelegate() {
    _addPage(seedPagesMap[SeedPages.spash]!);
  }
  List<Page> _pages = [];

  Page? _createPage(PageConfiguration configuration) {
    Widget? widget = Container(child: Text('nothing'));

    return MaterialPage(
      key: ValueKey(configuration.path + configuration.state.toString()),
      name: configuration.path,
      child: widget,
      arguments: configuration,
    );
  }

  void _addPage(PageConfiguration configuration) {
    if (configuration.path == seedPagesMap[SeedPages.home]!.path) {
      _pages.clear();
    } else {
      _pages.removeWhere((element) => element.arguments == configuration);
      _addToPage(configuration);
    }
    _buildPages();
  }

  void removePage(PageConfiguration configuration) {
    _pages.removeWhere((element) => element.arguments == configuration);
    _buildPages();
  }

  void _buildPages() {
    final homePageIndex = _pages
        .lastIndexWhere((p) => p.name == seedPagesMap[SeedPages.home]!.path);
    if (homePageIndex != -1) {
      _pages = _pages.sublist(homePageIndex);
    }
    if (_pages.isEmpty) {
      _addToPage(seedPagesMap[SeedPages.home]!);
    }

    notifyListeners();
  }

  void removeLastPage() {
    _pages.removeLast();
    _buildPages();
  }

  @override
  PageConfiguration? get currentConfiguration {
    if (_pages.isEmpty) {
      return null;
    }
    return _pages.last.arguments as PageConfiguration?;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
      child: Navigator(
        key: navigatorKey,
        pages: List.unmodifiable(_pages),
        onPopPage: (page, result) {
          if (!page.didPop(result)) {
            return false;
          }
          removeLastPage();
          return true;
        },
      ),
    );
  }

  void _addToPage(PageConfiguration config) {
    final p = _createPage(config);
    if (p == null) {
      return;
    }
    _pages.add(p);
  }

  @override
  Future<bool> popRoute() {
    if (currentConfiguration != null) {
      if (_pages.length == 1) {
        exit(0);
      } else {
        removeLastPage();
      }
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    _addPage(configuration);
  }

  @override
  GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}

class AppBackButtonDispatcher extends RootBackButtonDispatcher {
  AppBackButtonDispatcher(this._delegate) : super();
  final SeedRouterDelegate _delegate;
  @override
  Future<bool> didPopRoute() async {
    return _delegate.popRoute();
  }
}
