import 'package:foodorder/app/modules/productListPage/model/productListModel.dart';
import 'package:foodorder/app/modules/subcategoryList/model/subcategoryListModel.dart';

class HomeScreenModel {
  String? status;
  String? status_code;
  HomeScreenCategoryModel? data;

  HomeScreenModel({this.status, this.status_code, this.data});

  factory HomeScreenModel.fromJson(Map<String, dynamic> json) {
    return HomeScreenModel(
        status: json['status'],
        status_code: json['status_code'],
        data: HomeScreenCategoryModel.fromJson(json['data']));
  }
}

class HomeScreenCategoryModel {
  String? id;
  String? name;
  String? image;
  String? slug;
  List<SubCategoryListModel> subcategoryList;

  HomeScreenCategoryModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.slug,
      required this.subcategoryList});
  factory HomeScreenCategoryModel.fromJson(Map<String, dynamic> json) {
    List<SubCategoryListModel> subcategoryList = [];
   if (json.containsKey('subcategories')) {
      print('yesimage===');
      var list = json['subcategories'] as List;
      List<SubCategoryListModel> subcategoryListtem =
          list.map((e) => SubCategoryListModel.fromJson(e)).toList();
      subcategoryList = subcategoryListtem;
    }  
      
    
    return HomeScreenCategoryModel(
        id: json['id'].toString(),
        image: json['image'].toString(),
        name: json['name'].toString(),
        slug: json['slug'].toString(),
        subcategoryList: subcategoryList);
  }
}
