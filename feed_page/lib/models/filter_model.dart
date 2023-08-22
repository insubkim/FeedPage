import 'package:feed_page/models/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum EOrder { ascending, descending }

class FilterModel extends ChangeNotifier {
  final List<CategoryModel> _categories = [];
  EOrder order = EOrder.ascending;
  bool isNotSet = true;
  bool isChanged = false;

  void add(CategoryModel categoryModel) {
    _categories.add(categoryModel);
    isChanged = true;
    notifyListeners();
  }

  void remove(CategoryModel categoryModel) {
    for (int i = 0; i < _categories.length; i++) {
      if (categoryModel.id == _categories[i].id) {
        _categories.removeAt(i);
        break;
      }
    }
    isChanged = true;
    notifyListeners();
  }

  void setOrder(EOrder order) {
    this.order = order;
    isChanged = true;
    notifyListeners();
  }

  void setIsNotset(bool val) {
    isNotSet = val;
  }

  bool getIsNotSet() {
    return isNotSet;
  }

  get getIsChanged => isChanged;

  set setIsChanged(isChanged) => this.isChanged = isChanged;

  void setFilter(List<CategoryModel> list) {
    for (var x in list) {
      _categories.add(x);
    }
  }

  List<CategoryModel> getCategories() {
    return _categories;
  }

  EOrder getOrder() {
    return order;
  }

  bool hasID(int id) {
    for (var x in _categories) {
      if (x.id == id) {
        return true;
      }
    }
    return false;
  }

  String getCategoryNameById(int id) {
    for (var x in _categories) {
      if (x.id == id) {
        return x.name;
      }
    }
    return "";
  }
}
