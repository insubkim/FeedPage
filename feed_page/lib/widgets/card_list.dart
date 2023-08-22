import 'package:feed_page/models/ad_list_model.dart';
import 'package:feed_page/models/feed_list_model.dart';
import 'package:feed_page/models/filter_model.dart';
import 'package:feed_page/services/api_service.dart';
import 'package:feed_page/widgets/ad_post.dart';
import 'package:feed_page/widgets/question_post.dart';
import 'package:flutter/material.dart';

class CardList extends StatefulWidget {
  final FilterModel filterModel;
  const CardList({super.key, required this.filterModel});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  bool isLoading = false;
  late FeedListModel feedListModel = FeedListModel();
  late AdListModel adListModel = AdListModel();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> getData() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    FeedListModel feedTmp =
        await ApiService.getFeedList(feedListModel, widget.filterModel);
    AdListModel adTmp = await ApiService.getAdList(adListModel);
    setState(() {
      feedListModel.append(feedTmp);
      adListModel.append(adTmp);
      isLoading = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      getData();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.filterModel.isChanged) {
      _scrollController.removeListener(_scrollListener);
      _scrollController.dispose();
      feedListModel = FeedListModel();
      isLoading = false;
      getData();
      _scrollController = ScrollController();
      _scrollController.addListener(_scrollListener);
      widget.filterModel.isChanged = false;
    }
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount:
            feedListModel.feedList.isEmpty ? 1 : feedListModel.feedList.length,
        itemBuilder: (context, index) {
          if (feedListModel.feedList.isNotEmpty &&
              index < feedListModel.feedList.length) {
            return Column(
              children: [
                QuestionPost(
                  widget: widget,
                  feedListModel: feedListModel,
                  index: index,
                ),
                Divider(
                  color: Colors.black.withOpacity(0.07),
                  thickness: 12,
                ),
                AdPost(widget: widget, adListModel: adListModel, index: index),
                Divider(
                  color: Colors.black.withOpacity(0.07),
                  thickness: 12,
                ),
              ],
            );
          } else {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Text('');
            }
          }
        },
      ),
    );
  }
}
