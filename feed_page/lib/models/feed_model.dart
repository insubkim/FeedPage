import 'package:intl/intl.dart';

class FeedModel {
  final int id;
  final String title;
  late String contents;
  final int categoryId;
  final int userId;
  String created;
  String updated;
  late DateTime createdTime;
  late DateTime updatedTime;

  FeedModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        categoryId = json['category_id'],
        userId = json['user_id'],
        created = json['created_at'],
        updated = json['updated_at'] {
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

  get getId => id;

  get getTitle => title;

  get getContents => contents;

  get getCategoryId => categoryId;

  get getUserId => userId;

  get getCreated => created;

  get getUpdated => updated;

  get getCreatedTime => createdTime;

  get getUpdatedTime => updatedTime;
}
