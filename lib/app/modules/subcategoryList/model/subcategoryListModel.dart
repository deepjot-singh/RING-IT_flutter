class SubCategoryListModel {
  String id;
  String? name;
  String? image;
  String? categoryId;
  String? slug;
  SubCategoryListModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.slug,
      required this.categoryId});
  factory SubCategoryListModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryListModel(
      id: json['id'].toString(),
      image: json['image'].toString(),
      name: json['name'].toString(),
      categoryId: json['category_id'].toString(),
      slug: json['slug'].toString(),
    );
  }
}
