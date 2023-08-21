import 'package:feed_page/models/feed_model.dart';

class FeedListModel {
  int size = 0;
  final List<FeedModel> feedList = [];

  void add(FeedModel feedModel) {
    feedList.add(feedModel);
    size++;
  }

  get getSize => size;

  get getFeedList => feedList;
}
