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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
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
            Text(
              '오름차순',
              style: TextStyle(
                  color: _order == EOrder.ascending
                      ? Colors.black
                      : Colors.black.withOpacity(0.5)),
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
            Text(
              '내림차순',
              style: TextStyle(
                  color: _order == EOrder.descending
                      ? Colors.black
                      : Colors.black.withOpacity(0.5)),
            ),
            const Spacer(),
            OutlinedButton(
              child: Text(
                "필터",
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (context) => const AlertDialog(),
              ),
            ),
            // Expanded(
            //   child: RadioListTile(
            //     title: const Text(
            //       '오름차순',
            //       style: TextStyle(fontSize: 15),
            //     ),
            //     value: EOrder.ascending,
            //     groupValue: _order,
            //     onChanged: (value) {
            //       setState(() {
            //         _order = EOrder.ascending;
            //       });
            //     },
            //   ),
            // ),
            // Expanded(
            //   child: RadioListTile(
            //     title: const Text('내림차순'),
            //     value: EOrder.descending,
            //     groupValue: _order,
            //     onChanged: (value) {
            //       setState(() {
            //         _order = EOrder.descending;
            //       });
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
