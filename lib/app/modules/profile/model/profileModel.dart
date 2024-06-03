class ProfileModel {
  static ProfileModel? currentUser;
  String? id;
  String? name;
  String? email;
  String? country_code;
  String? phone_no;
  String? imgsrc;
  bool? isNotification;
  bool? isEmail;
  ProfileModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.country_code,
      required this.imgsrc,
      required this.isEmail,
      required this.isNotification,
      required this.phone_no});
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        id: json['id'].toString(),
        name: json['name'].toString() == 'null' ? "":json['name'].toString(),
        email: json['email'].toString()== 'null' ? "":json['email'].toString(),
        country_code: json['country_code'].toString()== 'null' ? "":json['country_code'].toString(),
        phone_no: json['phone_no'].toString()== 'null' ? "":json['phone_no'].toString(),
        imgsrc:json['avatar'].toString()== null ?"" :json['avatar'].toString(),
        isEmail:
            json['enable_email_notification'].toString() == "1" ? true : false,
        isNotification:
            json['enable_push_notification'].toString() == "1" ? true : false);
  }
}
