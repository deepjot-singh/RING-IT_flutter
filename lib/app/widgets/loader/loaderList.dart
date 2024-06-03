import 'package:flutter/material.dart';

Widget loaderList() {
  return Center(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        strokeWidth: 2,
      ),
    ),
  );
}

Widget loaderListWithoutPadding(
    {double width = 20.0,
    double height = 20.0,
    color = const Color.fromARGB(255, 52, 168, 83)}) {
  return Center(
    child: SizedBox(
      height: height,
      width: width,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: 1,
      ),
    ),
  );
}

Widget noDataFound({text}) {
  return Center(child: Text(text ?? "No data found"));
}
