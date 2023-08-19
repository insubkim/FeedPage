import 'package:flutter/material.dart';

class FeedHome extends StatefulWidget {
  const FeedHome({super.key});

  @override
  State<FeedHome> createState() => _FeedHomeState();
}

enum EOrder { ascending, descending }

class _FeedHomeState extends State<FeedHome> {
  //ascending if order = 0
  EOrder _order = EOrder.ascending;

  //Future<List<CategoryModel>> categories = ApiService.getCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
      ),
      body: Row(
        children: [
          Expanded(
            child: RadioListTile(
              title: const Text(
                '오름차순',
                style: TextStyle(fontSize: 15),
              ),
              value: EOrder.ascending,
              groupValue: _order,
              onChanged: (value) {
                setState(() {
                  _order = EOrder.ascending;
                });
              },
            ),
          ),
          Expanded(
            child: RadioListTile(
              title: const Text('내림차순'),
              value: EOrder.descending,
              groupValue: _order,
              onChanged: (value) {
                setState(() {
                  _order = EOrder.descending;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
