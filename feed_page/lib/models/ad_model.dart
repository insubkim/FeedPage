import 'package:intl/intl.dart';

class AdModel {
  final int id;
  final String title;
  late String contents;
  static const imgPath = 'https://cdn.comento.kr/assignment/';
  final String img;
  late String created;
  late String updated;
  late DateTime createdTime;
  late DateTime updatedTime;

  AdModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        img = imgPath + json['img'],
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
