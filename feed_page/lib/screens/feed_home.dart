import 'package:feed_page/models/category_model.dart';
import 'package:feed_page/models/filter_model.dart';
import 'package:feed_page/services/api_service.dart';
import 'package:feed_page/widgets/feed_filter.dart';
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
              builder: (context, value, child) {
                if (value.getIsNotSet()) {
                  value.setFilter(snapshot.data!);
                  value.setIsNotset(false);
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
                    for (int i = 0; i < value.getCategories().length; i++)
                      Text(value.getCategories()[i].name)
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

class OrderRadio extends StatefulWidget {
  const OrderRadio({super.key});

  @override
  State<OrderRadio> createState() => _OrderRadioState();
}

class _OrderRadioState extends State<OrderRadio> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FilterModel>(
      builder: (context, filter, child) {
        EOrder order = filter.getOrder();
        return Row(
          children: [
            SizedBox(
              width: 20,
              child: Transform.scale(
                scale: 0.5,
                child: Radio(
                  value: EOrder.ascending,
                  groupValue: order,
                  onChanged: (value) {
                    setState(() {
                      order = EOrder.ascending;
                      filter.setOrder(order);
                    });
                  },
                ),
              ),
            ),
            GestureDetector(
              child: Text(
                '오름차순',
                style: TextStyle(
                    color: order == EOrder.ascending
                        ? Colors.black
                        : Colors.black.withOpacity(0.5)),
              ),
              onTap: () {
                setState(() {
                  order = EOrder.ascending;
                  filter.setOrder(order);
                });
              },
            ),
            SizedBox(
              width: 20,
              child: Transform.scale(
                scale: 0.5,
                child: Radio(
                  value: EOrder.descending,
                  groupValue: order,
                  onChanged: (value) {
                    setState(() {
                      order = EOrder.descending;
                      filter.setOrder(order);
                    });
                  },
                ),
              ),
            ),
            GestureDetector(
              child: Text(
                '내림차순',
                style: TextStyle(
                    color: order == EOrder.descending
                        ? Colors.black
                        : Colors.black.withOpacity(0.5)),
              ),
              onTap: () {
                setState(() {
                  order = EOrder.descending;
                  filter.setOrder(order);
                });
              },
            ),
          ],
        );
      },
    );
  }
}
