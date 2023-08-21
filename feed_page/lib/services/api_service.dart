import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:feed_page/models/category_model.dart';

class ApiService {
  static const String baseUrl = 'https://problem.comento.kr';
  static const String categoryEndPoint = '/api/category';
  static Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categoryInstances = [];

    final url = Uri.parse('$baseUrl$categoryEndPoint');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> js = jsonDecode(response.body);
      for (var category in js['category']) {
        categoryInstances.add(CategoryModel.fromJson(category));
      }
      return categoryInstances;
    }
    throw Error();
  }
}
