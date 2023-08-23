import 'package:feed_page/models/ad_list_model.dart';
import 'package:feed_page/widgets/card_list.dart';
import 'package:flutter/material.dart';

class AdPost extends StatelessWidget {
  final CardList widget;
  final AdListModel adListModel;
  final int index;

  const AdPost(
      {super.key,
      required this.widget,
      required this.adListModel,
      required this.index});

  @override
  Widget build(BuildContext context) {
    int adjustedIndex = 0;
    if (index >= adListModel.adList.length) {
      int tmp = adListModel.adList.length;
      adjustedIndex = index - tmp;
    } else {
      adjustedIndex = index;
    }
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('sponsored',
              style: TextStyle(fontSize: 15, color: Colors.grey[400])),
          const SizedBox(
            height: 18,
          ),
          SizedBox(
            child: Image.network(adListModel.adList[adjustedIndex].img),
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            adListModel.adList[adjustedIndex].title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            adListModel.adList[adjustedIndex].contents,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
