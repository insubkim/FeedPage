import 'package:feed_page/widgets/card_list.dart';
import 'package:feed_page/widgets/category_filter.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../services/api_service.dart';

class FeedHome extends StatefulWidget {
  const FeedHome({super.key});

  @override
  State<FeedHome> createState() => _FeedHomeState();
}

enum EOrder { ascending, descending }

class _FeedHomeState extends State<FeedHome> {
  EOrder _order = EOrder.ascending;

  Future<List<CategoryModel>> categories = ApiService.getCategories();
  List<bool> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Transform.scale(
                    scale: 0.5,
                    child: Radio(
                      value: EOrder.ascending,
                      groupValue: _order,
                      onChanged: (value) {
                        setState(() {
                          _order = EOrder.ascending;
                        });
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  child: Text(
                    '오름차순',
                    style: TextStyle(
                        color: _order == EOrder.ascending
                            ? Colors.black
                            : Colors.black.withOpacity(0.5)),
                  ),
                  onTap: () {
                    setState(() {
                      _order = EOrder.ascending;
                    });
                  },
                ),
                SizedBox(
                  width: 20,
                  child: Transform.scale(
                    scale: 0.5,
                    child: Radio(
                      value: EOrder.descending,
                      groupValue: _order,
                      onChanged: (value) {
                        setState(() {
                          _order = EOrder.descending;
                        });
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  child: Text(
                    '내림차순',
                    style: TextStyle(
                        color: _order == EOrder.descending
                            ? Colors.black
                            : Colors.black.withOpacity(0.5)),
                  ),
                  onTap: () {
                    setState(() {
                      _order = EOrder.descending;
                    });
                  },
                ),
                const Spacer(),
                OutlinedButton(
                  child: Text(
                    "필터",
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (context) => CategoryFilter(
                      categories: categories,
                    ),
                  ),
                ),
              ],
            ),
            const CardList(),
          ],
        ),
      ),
    );
  }
}
