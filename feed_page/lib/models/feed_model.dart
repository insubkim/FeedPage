import 'package:intl/intl.dart';

class FeedModel {
  final int id;
  final String title;
  final String? content;
  final int categoryId;
  final int userId;
  String created;
  String updated;
  late DateTime createdTime;
  late DateTime updatedTime;

  FeedModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        categoryId = json['category_id'],
        userId = json['user_id'],
        created = json['created_at'],
        updated = json['updated_at'] {
    createdTime = DateTime.parse(created);
    created = DateFormat('yyyy-MM-dd').format(createdTime);
    updatedTime = DateTime.parse(created);
    updated = DateFormat('yyyy-MM-dd').format(createdTime);
  }

  get getId => id;

  get getTitle => title;

  get getContent => content;

  get getCategoryId => categoryId;

  get getUserId => userId;

  get getCreated => created;

  get getUpdated => updated;

  get getCreatedTime => createdTime;

  get getUpdatedTime => updatedTime;
}
