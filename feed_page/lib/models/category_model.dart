class CategoryModel {
  final int id;
  final String name;
  bool isSelected;
  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        isSelected = true;
}
