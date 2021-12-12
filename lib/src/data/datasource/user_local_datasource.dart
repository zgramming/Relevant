import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constant.dart';
import '../model/user/user_model.dart';

class UserLocalDataSource {
  Future<bool> saveSharedPreferences(User user) async {
    final sp = await SharedPreferences.getInstance();
    final encode = jsonEncode(user);
    final save = await sp.setString(keyUserSharedPreferences, encode);
    return save;
  }

  Future<bool> deleteSharedPreferences() async {
    final sp = await SharedPreferences.getInstance();
    final delete = await sp.remove(keyUserSharedPreferences);
    return delete;
  }

  Future<User?> fetchSharedPreferences() async {
    final sp = await SharedPreferences.getInstance();
    final encoded = sp.getString(keyUserSharedPreferences);
    if (encoded == null) {
      return null;
    }

    final decode = jsonDecode(encoded) as Map<String, dynamic>;
    final user = User.fromJson(decode);
    return user;
  }
}
