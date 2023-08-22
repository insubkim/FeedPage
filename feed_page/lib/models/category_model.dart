import 'package:intl/intl.dart';

class CategoryModel {
  final int id;
  final String name;

  late String created;
  late String updated;
  late DateTime createdTime;
  late DateTime updatedTime;

  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  CategoryModel.fromJsonWithTime(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        created = json['created_at'],
        updated = json['updated_at'] {
    createdTime = DateTime.parse(created);
    created = DateFormat('yyyy-MM-dd').format(createdTime);
    updatedTime = DateTime.parse(created);
    updated = DateFormat('yyyy-MM-dd').format(createdTime);
  }
}
