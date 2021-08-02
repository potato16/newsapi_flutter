import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:newsapi_flutter/src/core/error/exceptions.dart';
import 'package:newsapi_flutter/src/model/models/user_preferences.dart';

const String _USER_PREF_KEY = 'user_preferences_key';

abstract class UserPrefLocalDataSource {
  Future<UserPreferences> fetch();
  Future<void> save(UserPreferences user);
}

class UserPrefLocalDataSourceImpl extends UserPrefLocalDataSource {
  UserPrefLocalDataSourceImpl({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;
  @override
  Future<UserPreferences> fetch() async {
    final value = sharedPreferences.getString(_USER_PREF_KEY);

    if (value != null) {
      return UserPreferences.fromJson(json.decode(value));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> save(UserPreferences user) async {
    await sharedPreferences.setString(
        _USER_PREF_KEY, json.encode(user.toJson()));
  }
}
