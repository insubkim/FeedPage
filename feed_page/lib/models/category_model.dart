class CategoryModel {
  final int id;
  final String name;
  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
