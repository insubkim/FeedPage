import 'dart:convert';
import 'package:feed_page/models/ad_list_model.dart';
import 'package:feed_page/models/ad_model.dart';
import 'package:feed_page/models/detail_model.dart';
import 'package:feed_page/models/feed_list_model.dart';
import 'package:feed_page/models/feed_model.dart';
import 'package:feed_page/models/filter_model.dart';
import 'package:feed_page/models/reply_model.dart';
import 'package:http/http.dart' as http;
import 'package:feed_page/models/category_model.dart';

class ApiService {
  static const String baseUrl = 'https://problem.comento.kr';
  static const String categoryEndPoint = '/api/category';
  static const String feedListEndPoint = '/api/list';
  static const String adListEndPoint = '/api/ads';
  static const String viewEndPoint = '/api/view';

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

  static Future<FeedListModel> getFeedList(
      FeedListModel cardListFeedList, FilterModel filter) async {
    FeedListModel feedList = FeedListModel();
    List<String> category = [];
    if (filter.getCategories().isEmpty) {
      return feedList;
    }
    for (var x in filter.getCategories()) {
      category.add(x.id.toString());
    }
    int page = 1;
    cardListFeedList.filterModel = filter;
    final url =
        Uri.parse('$baseUrl$feedListEndPoint').replace(queryParameters: {
      'page': page.toString(),
      'ord': filter.getOrder() == EOrder.ascending ? 'asc' : 'desc',
      'category[]': category,
      'limit':
          (cardListFeedList.lastPage + cardListFeedList.perPage).toString(),
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> js = jsonDecode(response.body);
      for (var data in js['data']) {
        feedList.addFeedModel(FeedModel.fromJson(data));
      }
      feedList.curPage = cardListFeedList.lastPage + 1;
      feedList.lastPage = js['last_page'];
      feedList.perPage = js['per_page'];
      feedList.total = js['total'];
      if (feedList.curPage > feedList.total) {
        feedList.curPage = feedList.total;
      }
      return feedList;
    }
    throw Error();
  }

  static Future<AdListModel> getAdList(AdListModel cardListAdList) async {
    AdListModel adList = AdListModel();
    int page = 1;
    final url = Uri.parse('$baseUrl$adListEndPoint').replace(queryParameters: {
      'page': page.toString(),
      'limit': (cardListAdList.lastPage + cardListAdList.perPage).toString(),
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> js = jsonDecode(response.body);
      for (var data in js['data']) {
        adList.addAdModel(AdModel.fromJson(data));
      }
      adList.curPage = cardListAdList.lastPage + 1;
      adList.lastPage = js['last_page'];
      adList.perPage = js['per_page'];
      adList.total = js['total'];
      if (adList.curPage > adList.total) {
        adList.curPage = adList.total;
      }
      return adList;
    }
    throw Error();
  }

  static Future<DetailModel> getDetailModel(int id) async {
    DetailModel detailModel;
    final url = Uri.parse('$baseUrl$viewEndPoint').replace(queryParameters: {
      'id': id.toString(),
    });
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> js = jsonDecode(response.body);
      detailModel = DetailModel.fromJson(js['data']);
      for (var x in js['data']['reply']) {
        detailModel.replyModelList.add(ReplyModel.fromJson(x, x['user']));
      }
      return detailModel;
    }
    throw Error();
  }
}
