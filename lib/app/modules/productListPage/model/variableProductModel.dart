class VariableProductModel {
  int? id;
  int? product_id;
  int? attribute_id;
  String attribute_name;
  String is_multiple;
  List<Variations> variations;
  String errorMsg = "";

  VariableProductModel(
      {this.id,
      this.product_id,
      this.attribute_id,
      this.is_multiple = "",
      this.errorMsg = "",
      this.attribute_name = "",
      required this.variations});

  factory VariableProductModel.fromJson(Map<String, dynamic> json) {
    List<Variations> variationsModel = [];
    if (json.containsKey('variations')) {
      var list = json['variations'] as List;
      List<Variations> variationsModelTem =
          list.map((e) => Variations.fromJson(e)).toList();
      variationsModel = variationsModelTem;
    }
    return VariableProductModel(
        id: json["id"],
        product_id: json["product_id"],
        attribute_id: json["attribute_id"],
        is_multiple: json["is_multiple"].toString(),
        attribute_name: json["attribute_name"].toString(),
        variations: variationsModel);
  }
}

class Variations {
  int? id;
  int? product_attribute_id;
  int? variation_id;
  String regular_price;
  String sale_price;
  String regular_price_double;
  String sale_price_double;
  bool isChecked = false;
  VariationDetail variationDetail;
  Variations(
      {this.id,
      this.product_attribute_id,
      this.variation_id,
      this.isChecked = false,
      this.regular_price_double = "",
      this.sale_price_double = "",
      this.regular_price = "",
      this.sale_price = "",
      required this.variationDetail});
  factory Variations.fromJson(Map<String, dynamic> json) {
    return Variations(
        id: json["id"],
        product_attribute_id: json["product_attribute_id"],
        variation_id: json["variation_id"],
        regular_price: json["regular_price"].toString() != "null" &&
                json["regular_price"].toString() != "0.00"
            ? "₹${json["regular_price"].toString()}"
            : "",
        sale_price: json["sale_price"].toString() != "null" &&
                json["sale_price"].toString() != "0.00"
            ? "₹${json["sale_price"].toString()}"
            : "",
        regular_price_double: json["regular_price"].toString() != "null" &&
                json["regular_price"].toString() != "0.00"
            ? json["regular_price"].toString()
            : "",
        sale_price_double: json["sale_price"].toString() != "null" &&
                json["sale_price"].toString() != "0.00"
            ? json["sale_price"].toString()
            : "",
        variationDetail: VariationDetail.fromJson(json["variation_detail"]));
  }
}

class VariationDetail {
  int? id;
  String variation_name;

  VariationDetail({this.id, this.variation_name = ""});
  factory VariationDetail.fromJson(Map<String, dynamic> json) {
    return VariationDetail(
        id: json["id"], variation_name: json["variation_name"].toString());
  }
}
