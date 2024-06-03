class EmaiNotificationModel {
  String isEmail;
  String isNotification;

  EmaiNotificationModel({
    required this.isEmail,
    required this.isNotification,
  });

  factory EmaiNotificationModel.fromJson(Map<String, dynamic> json) =>
      EmaiNotificationModel(
        isEmail: json["is_email"].toString(),
        isNotification: json["is_notification"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "is_email": isEmail,
        "is_notification": isNotification,
      };
}
