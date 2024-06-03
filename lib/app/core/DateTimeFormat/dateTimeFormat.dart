import 'package:intl/intl.dart';

getPostReadableDate(serverDate) {
  DateTime d = DateTime.parse(serverDate);
  d = d.toLocal();
  String serverdate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").format(d);
  // var serverdate = DateTime.parse(json['createdAt'].toString());
  final currentDayDateNow = DateTime.now();
  String formattedDate =
      DateFormat('yyyy-MM-dd hh:mm a').format(currentDayDateNow);
  var diffDays = currentDayDateNow.difference(d).inDays;
  var diffHours = currentDayDateNow.difference(d).inHours;
  var diffMin = currentDayDateNow.difference(d).inMinutes;
  var finalDaysDiff = "just now";
  if (diffDays.toString() != "0") {
    if (diffDays > 0) {
      finalDaysDiff = diffDays.toString() + " day ago";
    } else {
      finalDaysDiff = "--";
    }
  } else if (diffHours.toString() != "0") {
    if (diffHours > 0) {
      finalDaysDiff = diffHours.toString() + " hour ago";
    } else {
      finalDaysDiff = " --";
    }
  } else if (diffMin.toString() != "0") {
    if (diffMin > 0) {
      finalDaysDiff = diffMin.toString() + " minute ago";
    } else {
      finalDaysDiff = "--";
    }
  } else {
    finalDaysDiff = "just now";
  }
  return finalDaysDiff;
}

//format will be 19 jan 2024 at 01:30AM
getDateFormat(serverDate) {
  DateTime d = DateTime.parse(serverDate);
  d = d.toLocal();
  String serverDateFormat = DateFormat("dd MMM yyyy").format(d);
  String serverTimeFormat = DateFormat("h:mm a").format(d);

  var finalDate = serverDateFormat + ' at ' + serverTimeFormat;

  return finalDate;
}
