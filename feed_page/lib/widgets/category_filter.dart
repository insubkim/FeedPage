import 'package:feed_page/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryFilter extends StatefulWidget {
  Future<List<CategoryModel>> categories;

  CategoryFilter({super.key, required this.categories});

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  List<bool> isSelected = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Container(
            alignment: FractionalOffset.topRight,
            child: GestureDetector(
              child: Icon(
                Icons.close,
                color: Colors.black.withOpacity(0.2),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            alignment: Alignment.centerLeft,
            child: const Text(
              '필터',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
            ),
          )
        ],
      ),
      content: FutureBuilder(
        future: widget.categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.length; i++) {
              if (i == 0 && isSelected.isNotEmpty) {
                break;
              }
              isSelected.add(snapshot.data![i].isSelected);
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < isSelected.length; i++)
                    Row(
                      children: [
                        Checkbox(
                          value: isSelected[i],
                          onChanged: (value) {
                            setState(() {
                              isSelected[i] = !isSelected[i];
                            });
                          },
                        ),
                        GestureDetector(
                          child: Text(snapshot.data![i].name),
                          onTap: () {
                            setState(() {
                              isSelected[i] = !isSelected[i];
                            });
                          },
                        ),
                      ],
                    ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
