import 'package:feed_page/models/feed_list_model.dart';
import 'package:feed_page/models/filter_model.dart';
import 'package:feed_page/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardList extends StatefulWidget {
  final FilterModel filterModel;
  const CardList({super.key, required this.filterModel});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  bool isLoading = false;
  late FeedListModel feedListModel = FeedListModel();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getFeedData();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> getFeedData() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    FeedListModel tmp =
        await ApiService.getFeedList(feedListModel, widget.filterModel);
    setState(() {
      feedListModel.append(tmp);
      isLoading = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      getFeedData();
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
      getFeedData();
      _scrollController = ScrollController();
      _scrollController.addListener(_scrollListener);
      widget.filterModel.isChanged = false;
    }
    return Consumer<FilterModel>(
      builder: (context, value, child) {
        return Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: feedListModel.feedList.isEmpty
                ? 1
                : feedListModel.feedList.length,
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
                    //광고
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
      },
    );
  }
}

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
    return Padding(
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
    );
  }
}
