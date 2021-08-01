import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeedPath {
  SeedPath._();
  static const String spash = '/';
  static const String home = '/home';
  static const String details = '/home/details';
}

final routeInformationParserProvider =
    Provider((ref) => SeedRouteInformationParser());

final Map<String, PageConfiguration> seedPagesMap = {
  SeedPath.spash: PageConfiguration(path: SeedPath.spash),
  SeedPath.home: PageConfiguration(path: SeedPath.home),
  SeedPath.details: PageConfiguration(path: SeedPath.details),
};

class SeedRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final Uri uri = Uri.parse(routeInformation.location ?? '');
    if (uri.pathSegments.isEmpty) {
      return PageConfiguration(path: SeedPath.home);
    }

    return PageConfiguration(path: uri.path, state: uri.queryParameters);
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    return RouteInformation(
      location: configuration.path,
      state: configuration.state,
    );
  }
}

class PageConfiguration extends Equatable {
  PageConfiguration({
    required this.path,
    this.state,
  });

  final String path;
  final Object? state;

  @override
  List<Object?> get props => [path, state];
  PageConfiguration copyWith({Object? state}) {
    return PageConfiguration(path: this.path, state: state ?? this.state);
  }
}
