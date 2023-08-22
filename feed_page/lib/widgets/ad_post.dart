import 'package:feed_page/models/ad_list_model.dart';
import 'package:feed_page/widgets/card_list.dart';
import 'package:flutter/material.dart';

class AdPost extends StatelessWidget {
  final CardList widget;
  final AdListModel adListModel;
  late int index;

  AdPost(
      {super.key,
      required this.widget,
      required this.adListModel,
      required this.index});

  @override
  Widget build(BuildContext context) {
    if (index >= adListModel.getAdList.length) {
      int tmp = adListModel.getAdList.length;
      index -= tmp;
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
            child: Image.network(adListModel.adList[index].img),
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            adListModel.adList[index].title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            adListModel.adList[index].contents,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
