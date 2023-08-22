import 'package:feed_page/models/ad_model.dart';

class AdListModel {
  int curPage = 0;
  int lastPage = 0;
  int perPage = 10;
  int total = -1;
  List<AdModel> adList = [];

  AdListModel();

  void append(AdListModel tmp) {
    adList.clear();
    for (var x in tmp.adList) {
      addAdModel(x);
    }
    curPage = tmp.curPage;
    lastPage = tmp.lastPage;
    perPage = tmp.perPage;
    total = tmp.total;
  }

  void addAdModel(AdModel adModel) {
    adList.add(adModel);
  }
}
