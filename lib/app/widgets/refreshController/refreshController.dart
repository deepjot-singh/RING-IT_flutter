import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SelectionListManager {
  RefreshController refreshController = RefreshController();
  TextEditingController searchTF = TextEditingController();
  var isLoading = false;
  var pageNo = 1;
  var isMultipleSelection = false;
  Timer? timer;

  List<int> selectedItem = [];
  List<int> selectedItemSize = [];
  var totalSelectedItem = [];
  List<double> priceListDouble = [];

  addtoItemsDouble(double val) {
    priceListDouble.add(val);
  }

  removeFromItemsDouble(double val) {
    priceListDouble.remove(val);
  }

  bool checkValueExistsDouble(double val) {
    return priceListDouble.contains(val);
  }

  addtoItems(int val) {
    selectedItem.add(val);
  }

  removeFromItems(int val) {
    selectedItem.remove(val);
  }

  bool checkValueExists(int val) {
    return selectedItem.contains(val);
  }

// For Size
  addtoItemsSize(int val) {
    selectedItemSize.add(val);
  }

  removeFromItemsSize(int val) {
    selectedItemSize.remove(val);
  }

  bool checkValueExistsSize(int val) {
    return selectedItemSize.contains(val);
  }

  cancelTimer() {
    if (timer != null) {
      timer?.cancel();
    }
  }

  timerInputSearch({onSearch, duration}) {
    cancelTimer();
    timer = Timer(Duration(milliseconds: duration ?? 500), () {
      cancelTimer();
      onSearch();
    });
  }
}
