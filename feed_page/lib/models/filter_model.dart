import 'package:feed_page/models/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum EOrder { ascending, descending }

class FilterModel extends ChangeNotifier {
  final List<CategoryModel> _categories = [];

  EOrder _order = EOrder.ascending;

  bool isNotSet = true;

  void add(CategoryModel categoryModel) {
    _categories.add(categoryModel);
    notifyListeners();
  }

  void remove(CategoryModel categoryModel) {
    _categories.remove(categoryModel);
    notifyListeners();
  }

  void setOrder(EOrder order) {
    _order = order;
    notifyListeners();
  }

  void setIsNotset(bool val) {
    isNotSet = val;
  }

  bool getIsNotSet() {
    return isNotSet;
  }

  void setFilter(List<CategoryModel> list) {
    for (var x in list) {
      _categories.add(x);
    }
  }

  List<CategoryModel> getCategories() {
    return _categories;
  }

  EOrder getOrder() {
    return _order;
  }

  bool hasID(int id) {
    for (var x in _categories) {
      if (x.id == id) {
        return true;
      }
    }
    return false;
  }
}
