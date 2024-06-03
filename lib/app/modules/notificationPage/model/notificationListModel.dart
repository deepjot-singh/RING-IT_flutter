import 'package:intl/intl.dart';

class NotificationListModel {
  String? id;
  String? title;
  String? message;
  String? type;
  String? createdAt;

  NotificationListModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) {
    return NotificationListModel(
      id: json['id'].toString(),
      title: json['title'].toString(),
      message: json['message'].toString(),
      type: json['type'].toString(),
      createdAt: json['created_at'].toString(),
    );
  }
}
