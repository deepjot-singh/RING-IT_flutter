class RestaurantListModel {
  String? image;
  String? id;
  String? name;
  String? speciality;
    String? rate;
  int? biZid;
  RestaurantListModel({
    this.name,
    this.id,
    this.image,
    this.rate,
    this.speciality,
  });

  factory RestaurantListModel.fromJson(Map<String, dynamic> json) {
    return RestaurantListModel(
      id: json['id'].toString(),
      image: json['image'],
      name: json['name'].toString(),
          rate: json['rate'].toString(),
      speciality: json['speciality'].toString(),
    );
  }
}
