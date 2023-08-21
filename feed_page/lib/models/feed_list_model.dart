import 'package:feed_page/models/feed_model.dart';

class FeedListModel {
  int fromPage = -1;
  int lastPage = -1;
  int perPage = -1;
  int total = -1;
  int curPage = 1;

  final List<FeedModel> feedList = [];

  FeedListModel();

  void add(FeedModel feedModel) {
    feedList.add(feedModel);
    curPage++;
  }

  get getcurPage => curPage;

  get getTotal => total;

  set setTotal(int total) => this.total = total;

  List<FeedModel> get getFeedList => feedList;
}
