// class AddressBookDataModel {
//   String? id;
//   String? userId;
//   String? addressType;
//   String? isDefaultAddress;
//   String? isAddress;

//   String? houseNumber;
//   String? landmark;
//   String? pincode;
//   String? latitude;
//   String? longitude;

//   AddressBookDataModel({
//     required this.id,
//     required this.longitude,
//     required this.latitude,
//     required this.userId,
//     required this.addressType,
//     this.isAddress="",
//     required this.houseNumber,
//     required this.landmark,
//     required this.pincode,
//     required this.isDefaultAddress,
//   });
//   factory AddressBookDataModel.fromJson(Map<String, dynamic> json) {
//     return AddressBookDataModel(
//       id: json['id'].toString(),
//       userId: json['user_id'].toString(),
//       addressType: json['address_type'].toString(),
//       longitude: json['longitude'].toString(),
//       latitude: json['latitude'].toString(),
//       houseNumber: json['house_number'].toString(),
//       landmark: json['landmark'].toString(),
//       pincode: json['pincode'].toString(),
//       isDefaultAddress: json['is_default_address'].toString(),
//     );
//   }
// }

// class AddressBookDataModel {
//     bool status;
//     int statusCode;
//     List<Datum> data;

//     AddressBookDataModel({
//         required this.status,
//         required this.statusCode,
//         required this.data,
//     });

//     factory AddressBookDataModel.fromJson(Map<String, dynamic> json) => AddressBookDataModel(
//         status: json["status"],
//         statusCode: json["status_code"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "status_code": statusCode,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

class AddressBookDataModel {
  int id;
  int userId;
  String? name;
  String? phoneNumber;
  String? countryCode;
  String? nearBy;
  String addressType;
  String houseNumber;
  String landmark;
  String locality;
  String pincode;
  String latitude;
  String longitude;
  String isDefaultAddress;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  AddressBookDataModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    required this.countryCode,
    required this.nearBy,
    required this.addressType,
    required this.houseNumber,
    required this.landmark,
    required this.locality,
    required this.pincode,
    required this.latitude,
    required this.longitude,
    required this.isDefaultAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory AddressBookDataModel.fromJson(Map<String, dynamic> json) =>
      AddressBookDataModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        countryCode: json["country_code"].toString() != "null" ? json["country_code"] : "",
        nearBy: json["near_by"] != 'null' ? json["near_by"] : "",
        addressType: json["address_type"],
        houseNumber: json["house_number"],
        landmark: json["landmark"],
        locality: json["locality"],
        pincode: json["pincode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isDefaultAddress: json["is_default_address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone_number": phoneNumber,
        "country_code": countryCode,
        "near_by": nearBy,
        "address_type": addressType,
        "house_number": houseNumber,
        "landmark": landmark,
        "locality": locality,
        "pincode": pincode,
        "latitude": latitude,
        "longitude": longitude,
        "is_default_address": isDefaultAddress,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
