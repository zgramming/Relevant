import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/user/user_register_model.dart';
import '../model/user/user_model.dart';

import '../../utils/utils.dart';

class UserRemoteDataSource {
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$apiUrl/login");
    final response = await http.post(
      url,
      body: {'email': email, 'password': password},
    );
    final decode = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      final map = decode['data'] as Map<String, dynamic>;
      final user = User.fromJson(map);
      return user;
    } else {
      if (decode.containsKey(VALIDATION_ERROR)) {
        final errors = decode[VALIDATION_ERROR] as Map<String, dynamic>;
        throw ValidationException(message: errors.values.join('\n'));
      }
      final message = decode['message'] as String;
      throw Exception(message);
    }
  }

  Future<User> register(UserRegisterModel user) async {
    final url = Uri.parse("$apiUrl/user");
    final body = {
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'password_confirmation': user.passwordConfirmation,
      'type': userTypeToValue[user.userType],
      if (user.userType == UserType.organisasi) ...{
        'id_type_organization': '${user.idTypeOrganization}',
        'address': '${user.address}',
      }
    };

    final response = await http.post(url, body: body);

    final decode = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      final map = decode['data'] as Map<String, dynamic>;
      final user = User.fromJson(map);
      return user;
    } else {
      if (decode.containsKey(VALIDATION_ERROR)) {
        final errors = decode[VALIDATION_ERROR] as Map<String, dynamic>;
        throw ValidationException(message: errors.values.join('\n'));
      }
      final message = decode['message'] as String;
      throw Exception(message);
    }
  }
}
