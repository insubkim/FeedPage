import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:feed_page/models/category_model.dart';

class ApiService {
  static const String baseUrl = 'https://problem.comento.kr';
  static const String category_end_point = '/api/category';
  static Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categoryInstances = [];

    final url = Uri.parse('$baseUrl$category_end_point');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> js = jsonDecode(response.body);
      for (var category in js['category']) {
        categoryInstances.add(CategoryModel.fromJson(category));
      }
      return categoryInstances;
    }
    //need catch error
    throw Error();
  }
}
