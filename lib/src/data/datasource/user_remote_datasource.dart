import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/utils.dart';
import '../model/user/user_change_password_form_model.dart';
import '../model/user/user_model.dart';
import '../model/user/user_register_form_model.dart';
import '../model/user/user_update_form_model.dart';

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

  Future<User> register(UserRegisterFormModel user) async {
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

  Future<User> update({
    required UserUpdateFormModel model,
  }) async {
    final url = Uri.parse('$apiUrl/user/${model.id}');
    final request = http.MultipartRequest("POST", url);

    request.fields['_method'] = 'PUT';
    request.fields['name'] = model.name;

    if (model.type == UserType.relawan) {
      request.fields['birth_date'] = '${model.birthDate}';
      request.fields['phone'] = model.phone;

      if (model.pictureProfile != null) {
        final setFile = await http.MultipartFile.fromPath(
          'picture_profile',
          model.pictureProfile!.path,
        );
        request.files.add(setFile);
      }
    } else {
      request.fields['address'] = model.address;
      request.fields['website'] = model.website;
      request.fields['whatsapp_contact'] = model.whatsappContact;
      request.fields['email_contact'] = model.emailContact;
      request.fields['instagram_contact'] = model.instagramContact;
      if (model.logo != null) {
        final setFile = await http.MultipartFile.fromPath(
          'logo',
          model.logo!.path,
        );
        request.files.add(setFile);
      }
    }

    final streamResponse = await request.send();
    final response = await http.Response.fromStream(streamResponse);
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

  Future<User> changePassword(UserChangePasswordFormModel model) async {
    final url = Uri.parse("$apiUrl/change_password");
    final response = await http.post(
      url,
      body: {
        'id_user': '${model.idUser}',
        'old_password': model.oldPassword,
        'new_password': model.newPassword,
        'new_password_confirmation': model.newPasswordConfirmation,
      },
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
}
