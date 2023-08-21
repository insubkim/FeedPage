import 'package:feed_page/models/feed_list_model.dart';
import 'package:feed_page/models/filter_model.dart';
import 'package:feed_page/services/api_service.dart';
import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  FilterModel filterModel;
  late Future<FeedListModel> feedList;
  CardList({super.key, required this.filterModel}) {
    feedList = ApiService.getFeedList(feedList, filterModel);
  }

  @override
  Widget build(BuildContext context) {
    return const Text('Card');
  }
}
