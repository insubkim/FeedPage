import 'package:feed_page/models/feed_model.dart';
import 'package:feed_page/models/filter_model.dart';

class FeedListModel {
  int curPage = 0;
  int lastPage = 0;
  int perPage = 10;
  int total = -1;
  late FilterModel filterModel;
  final List<FeedModel> feedList = [];

  FeedListModel();

  void append(FeedListModel tmp) {
    feedList.clear();
    for (var x in tmp.getFeedList) {
      addFeedModel(x);
    }
    curPage = tmp.curPage;
    lastPage = tmp.lastPage;
    perPage = tmp.perPage;
    total = tmp.total;
  }

  void addFeedModel(FeedModel feedModel) {
    feedList.add(feedModel);
  }

  List<FeedModel> get getFeedList => feedList;

//   bool checkFilterChange(FilterModel otherFilterModel) {
//     if (filterModel.getOrder() != otherFilterModel.getOrder()) {
//       return true;
//     }
//     for (int i = 0; i < filterModel.getCategories().length; i++) {
//       for (int j = 0; j < otherFilterModel.getCategories().length; j++) {
//         if (filterModel.getCategories()[i].getId ==
//             otherFilterModel.getCategories()[i].getId) {
//           break;
//         } else if (j == otherFilterModel.getCategories().length - 1) {
//           return true;
//         }
//       }
//     }
//     return false;
//   }
}
