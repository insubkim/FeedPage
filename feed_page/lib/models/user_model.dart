import 'package:intl/intl.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  late String emailVerifiedAt;
  late String created;
  late String updated;
  late DateTime emailVerifiedTime;
  late DateTime createdTime;
  late DateTime updatedTime;

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        emailVerifiedAt = json['email_verified_at'],
        created = json['created_at'],
        updated = json['updated_at'] {
    emailVerifiedTime = DateTime.parse(emailVerifiedAt);
    emailVerifiedAt = DateFormat('yyyy-MM-dd').format(emailVerifiedTime);
    createdTime = DateTime.parse(created);
    created = DateFormat('yyyy-MM-dd').format(createdTime);
    updatedTime = DateTime.parse(created);
    updated = DateFormat('yyyy-MM-dd').format(createdTime);
  }
}
