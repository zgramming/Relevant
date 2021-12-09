import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/type_organization/type_organization_model.dart';
import '../../utils/utils.dart';

class TypeOrganizationRemoteDataSource {
  Future<List<TypeOrganization>> get() async {
    final url = Uri.parse('$apiUrl/type_organization');
    final response = await http.get(url);
    final decode = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      final list = decode['data'] as List;
      final result =
          list.map((e) => TypeOrganization.fromJson(Map<String, dynamic>.from(e))).toList();
      return result;
    } else {
      final message = decode['message'];
      throw Exception(message);
    }
  }
}
