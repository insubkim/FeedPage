import 'package:feed_page/models/category_model.dart';
import 'package:feed_page/models/reply_model.dart';
import 'package:feed_page/models/user_model.dart';
import 'package:intl/intl.dart';

class DetailModel {
  final int id;
  final String title;
  final int categoryId;
  final int userId;

  late String contents;

  late String created;
  late String updated;
  late DateTime createdTime;
  late DateTime updatedTime;

  final CategoryModel categoryModel;
  final UserModel user;

  late List<ReplyModel> replyModelList = [];

  DetailModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        categoryId = json['category_id'],
        userId = json['user_id'],
        created = json['created_at'],
        updated = json['updated_at'],
        categoryModel = CategoryModel.fromJsonWithTime(json['category']),
        user = UserModel.fromJson(json['user']) {
    if (json['contents'] == Null) {
      contents = '';
    } else {
      contents = json['contents'];
    }
    createdTime = DateTime.parse(created);
    created = DateFormat('yyyy-MM-dd').format(createdTime);
    updatedTime = DateTime.parse(created);
    updated = DateFormat('yyyy-MM-dd').format(createdTime);
  }
}
