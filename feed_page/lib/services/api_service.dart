import 'dart:convert';
import 'package:feed_page/models/feed_list_model.dart';
import 'package:feed_page/models/feed_model.dart';
import 'package:feed_page/models/filter_model.dart';
import 'package:http/http.dart' as http;
import 'package:feed_page/models/category_model.dart';

class ApiService {
  static const String baseUrl = 'https://problem.comento.kr';
  static const String categoryEndPoint = '/api/category';
  static const String feedListEndPoint = '/api/list';

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

  static Future<void> getFeedList(
      FeedListModel feedList, FilterModel filter) async {
    final url = Uri.parse('$baseUrl$feedListEndPoint');
    final response = await http.get(url);
    //page = size + 1
    //ord = filter.order == EOrder.asc ? 'asc' : 'desc'
    //category
    //limit 10
    if (response.statusCode == 200) {
      final Map<String, dynamic> js = jsonDecode(response.body);
      for (var data in js['data']) {
        feedList.add(FeedModel.fromJson(data));
      }
      return;
    }
    throw Error();
  }
}
