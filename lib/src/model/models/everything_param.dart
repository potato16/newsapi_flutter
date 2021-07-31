import 'package:json_annotation/json_annotation.dart';

part 'everything_param.g.dart';

@JsonSerializable()
class EveryThingParams {
  EveryThingParams({
    this.q,
    this.qInTitle,
    this.sources,
    this.domains,
    this.excludeDomains,
    this.from,
    this.to,
    this.language,
    this.sortBy,
    this.pageSize,
    this.page,
  }) : assert(
            (q ?? '').trim().isNotEmpty ||
                (qInTitle ?? '').trim().isNotEmpty ||
                (sources ?? '').trim().isNotEmpty ||
                (domains ?? '').trim().isNotEmpty,
            'Required parameters are missing');
  factory EveryThingParams.fromJson(Map<String, dynamic> json) =>
      _$EveryThingParamsFromJson(json);
  Map<String, dynamic> toJson() => _$EveryThingParamsToJson(this);

  /// Keywords or phrases to search for in the article title and body.
  final String? q;

  /// Keywords or phrases to search for in the article title only.
  final String? qInTitle;

  /// A comma-seperated string of identifiers (maximum 20) for
  /// the news sources or blogs you want headlines from.
  final String? sources;

  /// A comma-seperated string of domains (eg bbc.co.uk, techcrunch.com, engadget.com)
  /// to restrict the search to.
  final String? domains;

  /// A comma-seperated string of domains (eg bbc.co.uk, techcrunch.com, engadget.com)
  /// to remove from the results.
  final String? excludeDomains;

  /// A date and optional time for the oldest article allowed.
  /// This should be in ISO 8601 format (e.g. 2021-07-30 or 2021-07-30T14:38:32)
  final String? from;

  /// A date and optional time for the newest article allowed.
  /// This should be in ISO 8601 format (e.g. 2021-07-30 or 2021-07-30T14:38:32)
  final String? to;

  // The 2-letter ISO-639-1 code of the language you want to get headlines for.
  final String? language;

  /// The order to sort the articles in.
  /// Possible options: `relevancy`, `popularity`, `publishedAt`.
  final String? sortBy;

  /// The number of results to return per page.
  final int? pageSize;

  /// Use this to page through the results.
  final int? page;
}
