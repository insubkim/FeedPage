import 'package:feed_page/models/feed_list_model.dart';
import 'package:feed_page/screens/feed_detail.dart';
import 'package:feed_page/widgets/card_list.dart';
import 'package:flutter/material.dart';

class QuestionPost extends StatelessWidget {
  const QuestionPost({
    super.key,
    required this.widget,
    required this.feedListModel,
    required this.index,
  });

  final CardList widget;
  final FeedListModel feedListModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, FeedDetail(id: feedListModel.feedList[index].id)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.filterModel.getCategoryNameById(
                      feedListModel.feedList[index].categoryId),
                  style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                ),
                Text(
                  '${feedListModel.feedList[index].id}',
                  style: TextStyle(fontSize: 15, color: Colors.grey[400]),
                ),
              ],
            ),
            Divider(
              color: Colors.grey[350],
              height: 20,
              thickness: 1,
            ),
            const SizedBox(
              height: 18,
            ),
            Text('${feedListModel.feedList[index].userId}'),
            const SizedBox(
              height: 18,
            ),
            Text(
              feedListModel.feedList[index].title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              feedListModel.feedList[index].contents,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
