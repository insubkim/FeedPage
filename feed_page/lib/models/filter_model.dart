import 'dart:collection';

import 'package:feed_page/models/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FilterModel extends ChangeNotifier {
  final List<CategoryModel> _categories = [];
  UnmodifiableListView<CategoryModel> get category =>
      UnmodifiableListView(_categories);

  void add(CategoryModel category) {
    _categories.add(category);
    notifyListeners();
  }

  void remove(CategoryModel category) {
    _categories.remove(category);
    notifyListeners();
  }
}
