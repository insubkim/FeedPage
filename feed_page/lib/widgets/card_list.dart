import 'package:feed_page/models/feed_list_model.dart';
import 'package:feed_page/models/filter_model.dart';
import 'package:feed_page/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardList extends StatefulWidget {
  FilterModel filterModel;
  CardList({super.key, required this.filterModel});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  bool isLoading = false;
  late FeedListModel feedList = FeedListModel();
  final ScrollController _scrollController = ScrollController();

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
    print('getFeedData size = ${feedList.getSize}');
    FeedListModel tmp =
        await ApiService.getFeedList(feedList.getSize + 1, widget.filterModel);
    setState(() {
      feedList.setTotal = tmp.getTotal;
      for (var x in tmp.getFeedList) {
        feedList.add(x);
      }
      isLoading = false;
    });
  }

  void _scrollListener() {
    if (feedList.getSize < feedList.getTotal &&
        _scrollController.position.pixels ==
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
    return Consumer<FilterModel>(
      builder: (context, value, child) {
        return Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: feedList.size + 1,
            itemBuilder: (context, index) {
              if (index < feedList.size) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(feedList.getFeedList[index].id.toString(),
                      style: const TextStyle(fontSize: 30)),
                );
              } else {
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Text('done');
                }
              }
            },
          ),
        );
      },
    );
  }
}
