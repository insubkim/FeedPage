import 'package:feed_page/models/category_model.dart';
import 'package:feed_page/models/filter_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedFilter extends StatefulWidget {
  final List<CategoryModel> categories;
  const FeedFilter({super.key, required this.categories});

  @override
  State<FeedFilter> createState() => _FeedFilterState();
}

class _FeedFilterState extends State<FeedFilter> {
  List<bool> isSelected = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.categories.length; i++) {
      isSelected.add(false);
    }
    for (int i = 0; i < widget.categories.length; i++) {
      if (context.read<FilterModel>().hasID(widget.categories[i].id)) {
        isSelected[i] = true;
      }
    }
  }

  void updateChecked(FilterModel filterModel) {
    for (int i = 0; i < widget.categories.length; i++) {
      if (isSelected[i] &&
          !(context.read<FilterModel>().hasID(widget.categories[i].id))) {
        context.read<FilterModel>().add(widget.categories[i]);
      } else if (!isSelected[i] &&
          (context.read<FilterModel>().hasID(widget.categories[i].id))) {
        context.read<FilterModel>().remove(widget.categories[i]);
      }
    }
  }

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
      content: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < widget.categories.length; i++)
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
                    child: Text(widget.categories[i].name),
                    onTap: () {
                      setState(() {
                        isSelected[i] = !isSelected[i];
                      });
                    },
                  ),
                ],
              ),
            Consumer<FilterModel>(
              builder: (context, value, child) {
                return GestureDetector(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40)),
                    onPressed: () {
                      updateChecked(value);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "저장하기",
                      style: TextStyle(
                          backgroundColor: Colors.blue, color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
