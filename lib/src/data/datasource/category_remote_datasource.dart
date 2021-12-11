import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/utils.dart';
import '../model/category/category_model.dart';

class CategoryRemoteDataSource {
  Future<List<Category>> get() async {
    final url = Uri.parse("$apiUrl/category");
    final response = await http.get(url);

    final decode = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      final list = decode['data'] as List;
      final result = list
          .map(
            (e) => Category.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList();
      return result;
    } else {
      final message = decode['message'];
      throw Exception(message);
    }
  }
}
