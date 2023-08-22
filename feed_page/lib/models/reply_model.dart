import 'package:feed_page/models/user_model.dart';
import 'package:intl/intl.dart';

class ReplyModel {
  final UserModel user;
  final int id;
  final int userId;
  final int parent;
  late String contents;

  late String created;
  late String updated;
  late DateTime createdTime;
  late DateTime updatedTime;

  ReplyModel.fromJson(Map<String, dynamic> json, Map<String, dynamic> idJson)
      : user = UserModel.fromJson(idJson),
        id = json['id'],
        userId = json['user_id'],
        parent = json['parent'],
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
}
