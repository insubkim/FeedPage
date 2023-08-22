import 'package:feed_page/models/category_model.dart';
import 'package:feed_page/models/filter_model.dart';
import 'package:feed_page/services/api_service.dart';
import 'package:feed_page/widgets/card_list.dart';
import 'package:feed_page/widgets/feed_filter.dart';
import 'package:feed_page/widgets/order_radio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FeedHome extends StatelessWidget {
  Future<List<CategoryModel>> categories = ApiService.getCategories();

  FeedHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<FilterModel>(
              builder: (context, filter, child) {
                if (filter.getIsNotSet()) {
                  filter.setFilter(snapshot.data!);
                  filter.setIsNotset(false);
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const OrderRadio(),
                          const Spacer(),
                          OutlinedButton(
                            child: Text(
                              "필터",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (context) => FeedFilter(
                                  categories: snapshot.data!,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey[350],
                      thickness: 1,
                      height: 4,
                    ),
                    CardList(filterModel: filter),
                  ],
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
