// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) {
  return UserPreferences(
    name: json['name'] as String?,
    country: json['country'] as String?,
    language: json['language'] as String?,
  );
}

Map<String, dynamic> _$UserPreferencesToJson(UserPreferences instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('country', instance.country);
  writeNotNull('language', instance.language);
  return val;
}
