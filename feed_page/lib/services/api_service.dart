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

  static Future<FeedListModel> getFeedList(int page, FilterModel filter) async {
    FeedListModel feedList = FeedListModel();
    List<String> category = [];
    if (filter.getCategories().isEmpty) {
      return feedList;
    }
    for (var x in filter.getCategories()) {
      category.add(x.id.toString());
    }
    final url =
        Uri.parse('$baseUrl$feedListEndPoint').replace(queryParameters: {
      'page': page.toString(),
      'ord': filter.getOrder() == EOrder.ascending ? 'asc' : 'desc',
      'category[]': category
      'limit': (page + 10).toString(),
    });
    print('api page = $page');
    print('api limit = ${page + 10}');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      print('api');
      final Map<String, dynamic> js = jsonDecode(response.body);
      for (var data in js['data']) {
        feedList.add(FeedModel.fromJson(data));
      }
      for (var x in feedList.getFeedList) {
        print(x.id.toString());
      }
      feedList.setTotal = js['total'];
      return feedList;
    }
    throw Error();
  }
}
