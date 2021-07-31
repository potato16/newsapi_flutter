import 'package:json_annotation/json_annotation.dart';

part 'headlines_param.g.dart';

@JsonSerializable()
class HeadLinesParams {
  HeadLinesParams({
    this.country,
    this.category,
    this.sources,
    this.q,
    this.pageSize,
    required this.page,
  }) : assert(page > 0, 'The page parameter cannot be less than 1.');

  factory HeadLinesParams.fromJson(Map<String, dynamic> json) =>
      _$HeadLinesParamsFromJson(json);
  Map<String, dynamic> toJson() => _$HeadLinesParamsToJson(this);

  /// The 2-letter ISO 3166-1 code of the country you want to get headlines for.
  final String? country;

  /// The category you want to get headlines for.
  /// Possible options: businessentertainmentgeneralhealthsciencesportstechnology.
  final String? category;

  /// A comma-seperated string of identifiers for
  ///the news sources or blogs you want headlines from.
  final String? sources;

  /// Keywords or a phrase to search for.
  final String? q;

  /// The number of results to return per page (request).
  /// 20 is the default, 100 is the maximum.
  final int? pageSize;

  /// Use this to page through the results
  /// if the total results found is greater than the page size.
  final int page;
}
