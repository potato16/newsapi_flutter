import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_preferences.g.dart';

@JsonSerializable()
class UserPreferences with EquatableMixin {
  UserPreferences({this.name, this.country, this.language});
  final String? name;
  final String? country;
  final String? language;
  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
  Map<String, dynamic> toJson() => _$UserPreferencesToJson(this);
  @override
  List<Object?> get props => [];
  UserPreferences copyWidth({String? name, String? country, String? language}) {
    return UserPreferences(
      name: name ?? this.name,
      country: country ?? this.country,
      language: language ?? this.language,
    );
  }
}
