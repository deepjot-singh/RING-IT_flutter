import 'package:foodorder/app/modules/productListPage/model/variableProductModel.dart';

class ProductsListModel {
  String? image;
  String? id;
  String? categoryId;
  String? subcategoryId;
  String? name;
  String? shortDescription;
  String? longDescription;
  String? productType;
  String regularPrice;
  String salePrice;
  int? quantity;
  bool loader = false;
  List<ImageListModel> imageListModel;
  List<VariableProductModel> variableProduct;
  List<dynamic>? productAttributeVariableId;

  ProductsListModel(
      {required this.name,
      required this.id,
      required this.image,
      required this.categoryId,
      required this.subcategoryId,
      required this.salePrice,
      required this.shortDescription,
      required this.longDescription,
      required this.variableProduct,
      required this.regularPrice,
      required this.productType,
      required this.imageListModel,
      this.quantity = 0,
      this.loader = false,
      this.productAttributeVariableId});

  factory ProductsListModel.fromJson(Map<String, dynamic> json) {
    print('pending: $json');
    List<ImageListModel> imageListModel = [];
    if (json.containsKey('images')) {
      print('yesimage===');
      var list = json['images'] as List;
      List<ImageListModel> imageListModelTem =
          list.map((e) => ImageListModel.fromJson(e)).toList();
      imageListModel = imageListModelTem;
    }

    List<VariableProductModel> variableProductModel = [];
    if (json.containsKey('variable_product')) {
      print('yesimage===');
      var list = json['variable_product'] as List;
      List<VariableProductModel> variableProductModelTem =
          list.map((e) => VariableProductModel.fromJson(e)).toList();
      variableProductModel = variableProductModelTem;
    }

    List<dynamic> productAttributeVariableIdList = [];
    if (json.containsKey('product_attribute_variable_id') &&
        json["product_attribute_variable_id"] != null) {
      print('yesimage===');
      var list = json['product_attribute_variable_id'] as List;
      List<dynamic> productAttributeVariableIdTemp =
          list.map((e) => e).toList();
      productAttributeVariableIdList = productAttributeVariableIdTemp;
    }

    return ProductsListModel(
        id: json['id'].toString(),
        image: json['image'],
        name: json['name'].toString(),
        categoryId: json['category_id'].toString(),
        subcategoryId: json['subcategory_id'].toString(),
        salePrice: json['sale_price'].toString() != "null"
            ? json['sale_price'].toString()
            : '0'.toString(),
        shortDescription: json['short_description'].toString() != "null"
            ? json['short_description'].toString()
            : "",
        longDescription: json['long_description'].toString() != "null"
            ? json['long_description'].toString()
            : "",
        productType: json['product_type'].toString(),
        regularPrice: json['regular_price'].toString() != "null"
            ? json['regular_price'].toString()
            : "0",
        imageListModel: imageListModel,
        variableProduct: variableProductModel,
        quantity: json['quantity'] ?? 0,
        productAttributeVariableId: productAttributeVariableIdList);
  }
}

class ImageListModel {
  String id;
  String productId;
  String image;

  ImageListModel(
      {required this.id, required this.productId, required this.image});
  factory ImageListModel.fromJson(Map<String, dynamic> json) {
    return ImageListModel(
        id: json['id'].toString(),
        productId: json['product_id'].toString(),
        image: json['image'].toString());
  }
}
